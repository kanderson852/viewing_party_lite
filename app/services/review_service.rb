class ReviewService
  def self.get_reviews(movie_id)
    initial_response = conn.get("movie/#{movie_id}/reviews")
    total_count = JSON.parse(initial_response.body, symbolize_names: true)[:total_pages]
    count = 1
    json = []
    until count > total_count do
      response = conn.get("movie/#{movie_id}/reviews", { page: count })
      json.push(JSON.parse(response.body, symbolize_names: true)[:results])
      count += 1
    end
    json.flatten
  end

  def self.conn
    url = 'https://api.themoviedb.org/3/'

    Faraday.new(url: url, params: { api_key: ENV['tmdb_api_key'] })
  end
end
