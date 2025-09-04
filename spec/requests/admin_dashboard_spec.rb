# frozen_string_literal: true

# context 'current trimester exists'...

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    context 'when current and upcoming trimesters exist' do
      before do
        current_trimester = Trimester.create!(
          term: 'Current term',
          year: Date.today.year.to_s,
          start_date: Date.today - 1.day,
          end_date: Date.today + 2.months,
          application_deadline: Date.today - 16.days
        )

        # Define past_trimester here and uncomment it when ready
        # past_trimester = Trimester.create!(
        #   term: 'Past term',
        #   year: '(Date.today.year - 1year).to_s',
        #   start_date: Date.today - 1.year - 1.day,
        #   end_date: Date.today + 2.months - 1.year,
        #   application_deadline: Date.today - 1.year - 16.days
        # )

        upcoming_trimester = Trimester.create!(
          term: 'Upcoming term',
          year: (Date.today + 6.months).year.to_s,
          start_date: Date.today + 6.months - 1.day,
          end_date: Date.today + 8.months,
          application_deadline: Date.today + 6.months - 16.days
        )

        coding_class1 = CodingClass.create!(
          title: 'Intro to Programming'
        )

        coding_class2 = CodingClass.create!(
          title: 'PHP'
        )

        @current_course1 = Course.create!(
          coding_class_id: coding_class1.id,
          trimester_id: current_trimester.id
        )

        @current_course2 = Course.create!(
          coding_class_id: coding_class2.id,
          trimester_id: current_trimester.id
        )

        @upcoming_course1 = Course.create!(
          coding_class_id: coding_class1.id,
          trimester_id: upcoming_trimester.id
        )

        @upcoming_course2 = Course.create!(
          coding_class_id: coding_class2.id,
          trimester_id: upcoming_trimester.id
        )
      end

      it 'returns a 200 OK status' do
        # Send a GET request to the dashboard route
        get '/dashboard'

        # Check that the response status is 200 (OK)
        expect(response).to have_http_status(:ok)
      end

      it 'displays the current trimester' do
        get '/dashboard'
        expect(response.body).to include("Current term - #{Date.today.year}")
      end

      it 'displays links to the courses in the current trimester' do
        get '/dashboard'
        expect(response.body).to include("/courses/#{@current_course1.id}")
        expect(response.body).to include("/courses/#{@current_course2.id}")
      end

      it 'displays the upcoming trimester' do
        get '/dashboard'
        expect(response.body).to include("Upcoming term - #{(Date.today + 6.months).year}")
      end

      it 'displays links to the courses in the upcoming trimester' do
        get '/dashboard'
        expect(response.body).to include("/courses/#{@upcoming_course1.id}")
        expect(response.body).to include("/courses/#{@upcoming_course2.id}")
      end
    end

    context 'when current and upcoming courses do not exist' do
      it 'returns a 200 OK status' do
        # Send a GET request to the dashboard route
        get '/dashboard'

        # Check that the response status is 200 (OK)
        expect(response).to have_http_status(:ok)
      end

      it 'returns the else statement for if there is no current trimester' do
        get '/dashboard'

        expect(response.body).to include('No current trimester')
      end

      it 'returns the else statement for if there is no upcoming trimester' do
        get '/dashboard'

        expect(response.body).to include('No upcoming trimester')
      end
    end
  end
end
