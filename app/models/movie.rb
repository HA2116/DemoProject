class Movie < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 150 }

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: :true
end
