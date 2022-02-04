class MovieFacade
  def self.movie_reviews(movie_id)
    json = ReviewService.get_reviews(movie_id)
    json.map do |review_data|
       Review.new(review_data)
    end
  end

  def self.movie_casts(movie_id)
    json = CastService.get_cast(movie_id)
    json[:cast].take(10).map do |cast_data|
      Cast.new(cast_data)
    end
  end

  def self.create_movie(movie_id, cast = nil, reviews = nil)
    reviews = MovieFacade.movie_reviews(movie_id)
    cast = MovieFacade.movie_casts(movie_id)
    movie_data = MovieService.get_movie(movie_id)

    Movie.new(movie_data, cast, reviews)
  end

  def self.top_20_movie_list
    movie_list_data = MovieService.top_rated_movies

    movie_list_data[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def self.search_movie_list(string)
    movie_list_data = MovieService.search_movies(string)

    movie_list_data.map do |movie|
      Movie.new(movie)
    end
  end
end
