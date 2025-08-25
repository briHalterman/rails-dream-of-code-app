require 'rails_helper'

RSpec.describe 'Mentors', type: :request do
  describe 'GET /mentors' do
    context 'mentors exist' do
      before do
        (1..2).each do |i|
          Mentor.create!(
            first_name: "Name #{i}",
            last_name: "Surname #{i}",
            email: "#{i}@email.com"
          )
        end
      end

      it 'returns a page containing names and info for all mentors' do
        get '/mentors'
        expect(response.body).to include('Name 1')
        expect(response.body).to include('Surname 2')
        expect(response.body).to include('Show this mentor')
      end
    end

    context 'mentors do not exist' do
      it 'returns a page containing no names of mentors' do
        get '/mentors'
        expect(response.body).to include('Mentors')
        expect(response.body).not_to include('Show this mentor')
      end
    end
  end
end