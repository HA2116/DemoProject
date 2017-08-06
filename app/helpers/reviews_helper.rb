module ReviewsHelper
  def display_user_first_name(review_user)
    review_user.first_name
  end
  def display_user_last_name(review_user)
    review_user.last_name
  end
  def display_user_email(review_user)
    review_user.email
  end

  def review_owner?(review_user, logged_in_user)
    review_user == logged_in_user if logged_in_user.present?
  end
end
