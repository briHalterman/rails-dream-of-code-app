# frozen_string_literal: true

module Api
  module V1
    class StudentsController < ApplicationController # rubocop:disable Style/Documentation
      skip_before_action :verify_authenticity_token

      def create # rubocop:disable Metrics/MethodLength
        student = Student.new(student_params)

        if student.save
          student_hash = {
            id: student.id,
            first_name: student.first_name,
            last_name: student.last_name,
            email: student.email
          }
          render json: { student: student_hash }, status: :created
        else
          render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def student_params
        params.require(:student).permit(:first_name, :last_name, :email)
      end
    end
  end
end
