class Movie < ActiveRecord::Base

  GENRES = ['comedy', 'horror', 'crime', 'action', 'drama', 'thriller', 'fantasy', 'animation']

  validates :title, presence: true, length: { maximum: 150 }
  validates :genre, presence: true, length: { maximum: 30 }, inclusion: { in: GENRES }

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: :true, reject_if: proc { |attributes| attributes['image'].blank? }

  has_many :castings, dependent: :destroy
  has_many :actors, through: :castings

  scope :latest, -> { order(release_date: :desc) }
  scope :featured, -> { where(featured: true) }

end
