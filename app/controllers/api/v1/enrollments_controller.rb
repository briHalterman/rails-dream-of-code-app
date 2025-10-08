# frozen_string_literal: true

module Api
  module V1
    class EnrollmentsController < ApplicationController # rubocop:disable Style/Documentation
      def index # rubocop:disable Metrics/MethodLength
        enrollments_hash = {
          enrollments: [
            {
              "id": 278,
              "studentId": 68,
              "studentFirstName": 'Bob',
              "studentLastName": 'Burger',
              "finalGrade": ''
            },
            {
              "id": 302,
              "studentId": 89,
              "studentFirstName": 'Marge',
              "studentLastName": 'Simpson',
              "finalGrade": ''
            }
          ]
        }

        render json: enrollments_hash, status: :ok
      end
    end
  end
end
