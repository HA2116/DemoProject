class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :select_actors, only: [:new, :edit]
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.get_filtered_movies(params[:filter]).page(params[:page])
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @review = @movie.reviews.new
    @reviews = @movie.reviews.page(params[:page])

    @rating = @movie.ratings.new
    if @movie.ratings.present?
      @ratings = @movie.ratings
      @average_rating = @movie.get_average_rating

      if user_signed_in?
        movie_ratings = @movie.ratings.get_ratings(current_user.id)
        if movie_ratings.present?
          @rating = movie_ratings.first
          @rating_score = @rating.score
        end
      end
    else
      @rating_score ||= 0
      @average_rating = 0
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def select_actors
      @actors_for_selection = Actor.all.pluck(:name, :id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :featured, :approved, :trailer, :genre, :release_date, images_attributes: [:id, :image, :_destroy], actor_ids: [])
    end

end
