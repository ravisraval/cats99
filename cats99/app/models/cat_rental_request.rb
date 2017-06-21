class CatRentalRequest < ApplicationRecord
  validates :status, presence: true, inclusion: { in: %w[APPROVED DENIED PENDING]}
  validates :cat_id, :start_date, :end_date, presence: true

  validate :does_not_overlap_approved_request

  belongs_to :cat, :class_name => "Cat", :foreign_key => "cat_id"


  def overlapping_requests
     CatRentalRequest.where(cat_id: self.cat_id).where.not(id: self.id).where(<<-SQL, start_d: start_date, end_d: end_date)
         NOT( (start_date > :end_d) OR (end_date < :start_d) )
      SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def does_not_overlap_approved_request
    return if self.status == "DENIED"
    if overlapping_approved_requests
      errors[:base] << "Request conflicts with an already approved request."
    end
    # overlapping_approved_requests.exists?
  end

  def approve!
    CatRentalRequest.transaction do
      does_not_overlap_approved_request
      self.status = "APPROVED"
      self.save
    end
    if self.status = "APPROVED"
      #deny all conflicting rentals
      CatRentalRequest.overlapping_pending_requests.each do |req|
        req.deny!
      end
    else
      deny!
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def deny!
    self.status = "DENIED"
  end

end
