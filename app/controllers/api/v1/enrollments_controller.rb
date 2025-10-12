# frozen_string_literal: true

module Api
  module V1
    class EnrollmentsController < ApplicationController # rubocop:disable Style/Documentation
      def index # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        @current_trimester = Trimester.where('start_date <= ?', Date.today).where('end_date >= ?', Date.today).first
        @courses = @current_trimester.courses
        @course = Course.find(params[:course_id])
        @enrollments = @course.enrollments

        # Expected data shape:
        # Sample data
        #
        # enrollments_hash = {
        #   enrollments: [
        #     {
        #       "id": 278,
        #       "studentId": 68,
        #       "studentFirstName": 'Bob',
        #       "studentLastName": 'Burger',
        #       "finalGrade": ''
        #     },
        #     {
        #       "id": 302,
        #       "studentId": 89,
        #       "studentFirstName": 'Marge',
        #       "studentLastName": 'Simpson',
        #       "finalGrade": ''
        #     }
        #   ]
        # }

        enrollments_hash = {
          enrollments: []
        }

        @enrollments.each do |enrollment|
          enrollments_hash[:enrollments] << {
            id: enrollment.id,
            studentId: enrollment.student_id,
            studentFirstName: enrollment.student.first_name,
            studentLastName: enrollment.student.last_name,
            finalGrade: enrollment.final_grade
          }
        end

        render json: enrollments_hash, status: :ok
      end
    end
  end
end
