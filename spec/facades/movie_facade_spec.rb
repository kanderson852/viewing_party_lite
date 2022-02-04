require 'rails_helper'

RSpec.describe MovieFacade, type: :facade do
  context 'class methods' do
    describe '::movie_reviews', :vcr do
      it 'should return array of review objects' do
        movie_review = MovieFacade.movie_reviews(11)

        expect(movie_review).to be_a(Array)
        expect(movie_review[0]).to be_a(Review)
      end
    end

    describe '::movie_casts', :vcr do
      it 'should return array of cast objects' do
        movie_cast = MovieFacade.movie_casts(11)
        expect(movie_cast).to be_a(Array)
        expect(movie_cast[0]).to be_a(Cast)
        expect(movie_cast.length).to eq(10)
      end

      it 'should return an array of objects even if cast is less than 10' do
        movie_cast2 = MovieFacade.movie_casts(49047)
        expect(movie_cast2.length).to eq(7)
      end
    end

    describe '::create_movie', :vcr do
      it 'should return movie objects with reviews and cast' do
        star_wars = MovieFacade.create_movie(11)

        expect(star_wars).to be_a(Movie)
        expect(star_wars.reviews.first).to be_a(Review)
        expect(star_wars.cast.first).to be_a(Cast)
      end
      it 'can get all reviews for the movie' do
        avengers = MovieFacade.create_movie(299536)
        require "pry"; binding.pry
        expect(avengers).to be_a(Movie)
        expect(avengers.reviews.count).to eq(30)
      end
    end

    describe '::top_20_movie_list', :vcr do
      it 'should return array movie objects' do
        movie_list = MovieFacade.top_20_movie_list

        expect(movie_list).to be_a(Array)
        expect(movie_list.first).to be_a(Movie)
        expect(movie_list.count).to eq(20)
      end

    end

    describe '::search_movie_list', :vcr do
      it 'should return an array of queried movie objects' do
        movie_list = MovieFacade.search_movie_list('star')

        expect(movie_list).to be_a(Array)
        expect(movie_list.first).to be_a(Movie)
      end

      it 'should return 40 movies if able' do
        movie_list = MovieFacade.search_movie_list('star')

        expect(movie_list.count).to eq(40)
      end

      it 'should return less than 40 movies if there are less' do
        movie_list = MovieFacade.search_movie_list('spaceballs')

        expect(movie_list.count).to eq(2)
      end

      it 'should return no movies if there are no matching' do
        movie_list = MovieFacade.search_movie_list('asldgahskgadshjlg')

        expect(movie_list.count).to eq(0)
      end
    end
  end
end
