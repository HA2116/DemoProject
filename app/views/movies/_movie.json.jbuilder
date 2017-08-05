json.extract! movie, :id, :title, :description, :trailer, :featured, :approved, :created_at, :updated_at
json.url movie_url(movie, format: :json)
