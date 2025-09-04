# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StudentsRecent', type: :request do
  describe 'GET /students_recent' do
    it 'responds with 200 OK' do
      get '/students/recent'
      expect(response).to have_http_status(:ok)
    end

    context 'students exist' do
      it 'lists the most recently created students first' do
        Student.create!(first_name: 'Ada', last_name: 'Lovelace', email: 'a@e.com',
                        created_at: 2.days.ago)
        Student.create!(first_name: 'Grace', last_name: 'Hopper', email: 'g@e.com',
                        created_at: 1.hour.ago)

        get '/students/recent'

        expect(response.body).to include('Ada Lovelace', 'Grace Hopper')

        expect(response.body).to match(/Grace Hopper.*Ada Lovelace/m)
      end

      it 'links each name to the student show page' do
        student = Student.create!(first_name: 'KJ', last_name: 'Loving', email: 'kj@test.com')

        get '/students/recent'

        expect(response.body).to include("students/#{student.id}")
      end
    end

    context 'students do not exist' do
      it 'returns a page declaring there are no students' do
        get '/students/sorted'

        expect(response.body).to include('No students yet')
      end
    end
  end
end
