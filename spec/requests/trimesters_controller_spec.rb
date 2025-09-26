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

  describe 'GET /trimesters/:id/edit' do
    let!(:trimester) do
      Trimester.create!(
        term: 'Test Term',
        year: '2025',
        start_date: '2025-01-01',
        end_date: '2025-01-01',
        application_deadline: '2025-01-01'
      )
    end

    it 'displays the application deadline label' do
      get "/trimesters/#{trimester.id}/edit"
      expect(response.body).to include('Application deadline')
    end
  end

  describe 'PUT /trimesters/:id' do
    let!(:trimester) do
      Trimester.create!(
        term: 'Test Term',
        year: '2025',
        start_date: '2025-01-01',
        end_date: '2025-01-01',
        application_deadline: '2025-01-01'
      )
    end

    it "updates a trimester's application deadline when deadline is valid and trimester exists" do
      put "/trimesters/#{trimester.id}", params: {
        trimester: { application_deadline: "2026-01-01"}
      }
      # Test redirect
      expect(response).to redirect_to(trimester)
      # Reload trimester to refresh data and assert that title is updated
      trimester.reload
      expect(trimester.application_deadline.to_s).to eq("2026-01-01")
    end

    it "responds with 400 status when no application deadline is provided" do
      put "/trimesters/#{trimester.id}"

      expect(response).to have_http_status(:bad_request)
    end

    it "responds with 400 status when application deadline is not a valid date" do
      put "/trimesters/#{trimester.id}", params: {
        trimester: { application_deadline: "not a date"}
      }

      expect(response).to have_http_status(:bad_request)
    end

    it 'responds with 404 status when trimester id does not belong to an existing trimester' do
      put "/trimesters/nope", params: {
        trimester: { application_deadline: "trimester does not exist" }
      }

      expect(response).to have_http_status(:not_found)
    end
  end
end
