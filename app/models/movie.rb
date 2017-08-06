class Movie < ActiveRecord::Base
  paginates_per 3

  GENRES = ['comedy', 'horror', 'crime', 'action', 'drama', 'thriller', 'fantasy', 'animation']

  validates :title, presence: true, length: { maximum: 150 }
  validates :genre, presence: true, length: { maximum: 30 }, inclusion: { in: GENRES }

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: :true, reject_if: proc { |attributes| attributes['image'].blank? }

  has_many :castings, dependent: :destroy
  has_many :actors, through: :castings
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy

  scope :approved, -> { where(approved: true) }
  scope :featured, -> { where(approved: true, featured: true) }
  scope :latest, -> { where(approved: true).order(release_date: :desc) }

  def self.get_filtered_movies(movie_filter)
    if movie_filter == 'latest'
      self.latest
    elsif movie_filter == 'featured'
      self.featured
    else
      self.approved
    end
  end

  def get_average_rating
    ratings.present? ? ratings.average(:score) : 0
  end

end
