class Review < ActiveRecord::Base
  paginates_per 3

  validates :comment, presence: true

  belongs_to :movie
  belongs_to :user

end
