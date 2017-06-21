class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = ['white','black','tabby','grey','brown','pink']
  validates :color, inclusion: {in: COLORS, message: "not valid color" }, presence: true
  validates :sex, inclusion: {in: ["F", "M"], message: "not valid" }, presence: true
  validates :name, :description, :birth_date, presence: true

  has_many :rentalrequests, :class_name => "CatRentalRequest",
  :foreign_key => "cat_id", dependent: :destroy


  def age
    time_ago_in_words(birth_date)
  end

end
