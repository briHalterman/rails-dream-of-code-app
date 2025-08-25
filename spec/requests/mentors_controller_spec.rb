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

  describe 'GET /mentors/:id', type: :request do
    let!(:mentor) do
      Mentor.create!(
        first_name: 'Test name',
        last_name: 'Surname',
        email: 'test@email.com',
        max_concurrent_students: 6
      )
    end

    it 'returns a page containing the info of a mentor' do
      get "/mentors/#{mentor.id}"
      expect(response.body).to include('First name:')
      expect(response.body).to include('Test name')
      expect(response.body).to include('Last name:')
      expect(response.body).to include('Surname')
      expect(response.body).to include('Email:')
      expect(response.body).to include('test@email.com')
      expect(response.body).to include('Max concurrent students:')
      expect(response.body).to include('6')
    end
  end
end
