require 'rails_helper'

RSpec.describe MovieService, type: :service do
  context 'class methods', :vcr do
    describe '::conn' do
      it 'returns Faraday connection' do
        movie = MovieService.conn

        expect(movie).to be_a(Faraday::Connection)
      end
    end

    describe '::get_movie' do
      it 'returns hash of movie details' do
        movie = MovieService.get_movie(11)

        expect(movie).to be_a(Hash)
      end
    end

    describe '::top_rated_movies' do
      it 'returns hash of top movies' do
        top_rated = MovieService.top_rated_movies

        expect(top_rated).to be_a(Hash)
      end
    end

    describe '::search_movies' do
      it 'returns array of movies searched by query' do
        search = MovieService.search_movies('star')

        expect(search.first[:title].downcase).to include('star')
        expect(search).to be_a(Array)
      end

      it 'returns array of max 40 movies if more than 40 matches' do
        search = MovieService.search_movies('star')

        expect(search.count).to eq(40)
      end

      it 'returns array of less than 40 movies if less are found' do
        search = MovieService.search_movies('spaceballs')

        expect(search.count).to eq(2)
      end

      it 'returns a blank array if no movies found' do
        search = MovieService.search_movies('asdfasdfasgagh')

        expect(search.empty?).to eq(true)
      end
    end
  end
end
