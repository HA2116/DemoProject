class PagesController < ApplicationController
  def home
    @latest_movies = Movie.latest.first(3)
    @featured_movies = Movie.featured.first(3)
  end
end
