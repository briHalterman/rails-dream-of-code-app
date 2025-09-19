# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  # What are the test scenarios?
  # We need to test if the application deadline is on or before the deadline,
  # and also if it is after.

  describe '#is_past_application_deadline' do
    let(:student) do
      Student.create!(first_name: 'Test', last_name: 'Tester', email: 'test@gmail.com')
    end

    let(:coding_class) do
      CodingClass.create!(title: 'Test')
    end

    context 'when the student enrolled after the deadline' do
      let(:trimester) do
        Trimester.create!(
          year: '1996',
          start_date: '1996-05-01',
          end_date: '1996-08-30',
          application_deadline: '1996-04-15'
        )
      end

      let(:course) do
        Course.create!(coding_class_id: coding_class.id, trimester_id: trimester.id)
      end

      let(:enrollment) do
        Enrollment.create!(course_id: course.id, student_id: student.id)
      end

      it 'returns true' do
        expect(enrollment.is_past_application_deadline?).to eq(true)
      end
    end

    context 'when the student enrolled before the deadline' do
      let(:trimester) do
        Trimester.create!(
          year: '1996',
          start_date: '1996-05-01',
          end_date: '1996-08-30',
          application_deadline: Date.current + 1
        )
      end

      let(:course) do
        Course.create!(coding_class_id: coding_class.id, trimester_id: trimester.id)
      end

      let(:enrollment) do
        Enrollment.create!(course_id: course.id, student_id: student.id)
      end

      it 'returns false' do
        expect(enrollment.is_past_application_deadline?).to eq(false)
      end
    end
  end
end
