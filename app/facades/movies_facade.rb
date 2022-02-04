class MoviesFacade
  def self.movie_reviews(movie_id)
    json = ReviewService.get_reviews(movie_id)

    json[:results].map do |review_data|
      Review.new(review_data)
    end
  end

  # def self.movie_list

  # end
end
