class Rating < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  scope :get_ratings, -> (logged_in_user) { where(user_id: logged_in_user) }
end
