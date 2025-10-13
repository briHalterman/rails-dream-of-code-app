# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request do
  describe 'POST /api/v1/students' do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    it 'creates a new student' do
      expect do
        post '/api/v1/students', params: valid_attributes
      end.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq('validstudent@example.com')
    end

    it 'responds with 422 status when no first name is provided' do
      post '/api/v1/students', params: {
        student: {
          first_name: '',
          last_name: Faker::Name.last_name,
          email: 'student@example.com'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'responds with 422 status when no last name is provided' do
      post '/api/v1/students', params: {
        student: {
          first_name: Faker::Name.first_name,
          last_name: '',
          email: 'student@example.com'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'responds with 400 status when no email is provided' do
      post '/api/v1/students', params: {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: ''
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
