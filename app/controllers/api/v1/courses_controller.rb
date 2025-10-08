# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController # rubocop:disable Style/Documentation
      def index # rubocop:disable Metrics/MethodLength
        courses_hash = {
          courses: [
            {
              id: 55,
              title: 'Intro to Programming',
              application_deadline: '2025-01-15',
              start_date: '2025-01-15'
            },
            {
              id: 61,
              title: 'Ruby on Rails',
              application_deadline: '2025-01-15',
              start_date: '2025-01-15',
              end_date: '2025-01-15'
            }
          ]
        }

        render json: courses_hash, status: :ok
      end
    end
  end
end
