require 'rails_helper'

RSpec.describe ReviewService, type: :service do
  context 'class methods' do
    describe '::conn', :vcr do
      it 'returns Faraday connection' do
        reviews = ReviewService.conn

        expect(reviews).to be_a(Faraday::Connection)
      end
    end

    describe '::get_reviews', :vcr do
      it 'returns array of reviews' do
        reviews = ReviewService.get_reviews(11)

        expect(reviews).to be_a(Array)
        expect(reviews.count).to eq(4)
      end
      it 'returns all reviews if over 20' do
        reviews = ReviewService.get_reviews(299536)

        expect(reviews.count).to eq(30)
      end
    end
  end
end
