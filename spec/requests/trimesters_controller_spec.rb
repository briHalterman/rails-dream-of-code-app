# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trimesters', type: :request do
  describe 'GET /trimesters' do
    context 'trimesters exist' do
      before do
        (1..2).each do |i|
          Trimester.create!(
            term: "Term #{i}",
            year: '2025',
            start_date: '2025-01-01',
            end_date: '2025-01-01',
            application_deadline: '2025-01-01'
          )
        end
      end

      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end

    context 'trimesters do not exist' do
      it 'returns a page containing no names of trimesters' do
        get '/trimesters'
        expect(response.body).to include('Trimesters')
        expect(response.body).not_to include('<li>')
      end
    end
  end

  describe 'GET /trimesters/:id', type: :request do
    let!(:trimester) do
      Trimester.create!(
        term: 'Test Term',
        year: '2025',
        start_date: '2025-01-01',
        end_date: '2025-01-01',
        application_deadline: '2025-01-01'
      )
    end

    it 'returns a page containing the info of a trimester' do
      get "/trimesters/#{trimester.id}"
      expect(response.body).to include('Test Term')
    end
  end
end
