class Movie
  attr_reader :title,
              :movie_id,
              :genres,
              :runtime,
              :vote_average,
              :summary,
              :cast,
              :reviews

  def initialize(data, cast = nil, reviews = nil)
    @title = data[:title]
    @movie_id = data[:id]
    @genres = create_genres(data)
    @runtime = data[:runtime]
    @vote_average = data[:vote_average]
    @summary = data[:overview]
    @cast = cast
    @reviews = reviews
  end

  def create_genres(data)
    data[:genres].pluck(:name).join(', ') unless data[:genres].nil?
  end
end
