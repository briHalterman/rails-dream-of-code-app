# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController # rubocop:disable Style/Documentation
      def index # rubocop:disable Metrics/MethodLength
        @current_trimester = Trimester.where('start_date <= ?', Date.today).where('end_date >= ?', Date.today).first
        @courses = @current_trimester.courses

        # debugger

        # courses_hash = {
        #   courses: [
        #     {
        #       id: 55,
        #       title: 'Intro to Programming',
        #       application_deadline: '2025-01-15',
        #       start_date: '2025-01-15'
        #     },
        #     {
        #       id: 61,
        #       title: 'Ruby on Rails',
        #       application_deadline: '2025-01-15',
        #       start_date: '2025-01-15',
        #       end_date: '2025-01-15'
        #     }
        #   ]
        # }

        courses_hash = {
          courses: []
        }

        @courses.each do |course|
          courses_hash[:courses] << {
            id: course.id,
            title: course.title,
            application_deadline: @current_trimester.application_deadline,
            start_date: @current_trimester.start_date
          }
        end

        render json: courses_hash, status: :ok
      end
    end
  end
end
