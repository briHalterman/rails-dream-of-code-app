# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments
  has_many :lessons

  def student_name_list
    student_names = []
    enrollments.each do |enrollment|
      student_names << "#{enrollment.student.first_name} #{enrollment.student.last_name}"
    end

    student_names
  end

  def student_email_list
    student_emails = []
    enrollments.each do |enrollment|
      student_emails << enrollment.student.email.to_s
    end

    student_emails
  end

  delegate :title, to: :coding_class
end
