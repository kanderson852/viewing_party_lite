class MovieService
  def self.get_movie(movie_id)
    response = conn.get("movie/#{movie_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.top_rated_movies
    response = conn.get('movie/top_rated')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search_movies(string)
    json = []
    2.times do |i|
      response = conn.get('search/movie', { query: string, page: i + 1 })
      json.push(JSON.parse(response.body, symbolize_names: true)[:results])
    end
    json.flatten!
  end

  def self.conn
    url = 'https://api.themoviedb.org/3/'

    Faraday.new(url: url, params: { api_key: ENV['tmdb_api_key'] })
  end
end
