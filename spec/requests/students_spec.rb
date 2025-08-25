require 'rails_helper'

RSpec.describe 'Students', type: :request do
  describe 'GET /students' do
    context 'trimesters exist' do
      let!(:student) do
        Student.create(
          first_name: 'KJ',
          last_name: 'Loving',
          email: 'kj@test.com'
        )
      end

      let!(:student2) do
        Student.create(
          first_name: 'AJ',
          last_name: 'Suning',
          email: 'aj@test.com'
        )
      end

      # Example
      # it 'returns a page containing names of all trimesters' do
      #   get '/trimesters'
      #   expect(response.body).to include('Term 1 2025')
      #   expect(response.body).to include('Term 2 2025')
      # end

      it 'returns a page containing names of all students' do
        get '/students'
        expect(response.body).to include('First name:')
        expect(response.body).to include('AJ')
      end
    end
  end
end
