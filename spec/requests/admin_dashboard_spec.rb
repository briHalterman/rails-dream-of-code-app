require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      # Define past_trimester here and uncomment it when ready
      # past_trimester = Trimester/create!(
      #   term: 'Past term',
      #   year: '(Date.today.year - 1year).to_s',
      #   start_date: Date.today - 1.year - 1.day,
      #   end_date: Date.today + 2.months - 1.year,
      #   application_deadline: Date.today - 1.year - 16.days
      # )
    end

    it 'returns a 200 OK status' do
      # Send a GET request to the dashboard route
      get '/dashboard'

      # Check that the response status is 200 (OK)
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get '/dashboard'
      expect(response.body).to include("Current term #{Date.today.year} Courses")
    end

    it 'displays links to the courses in the current trimester' do
    end

    it 'displays the upcoming trimester' do
    end

    it 'displays links to the courses in the upcoming trimester' do
    end
  end
end
