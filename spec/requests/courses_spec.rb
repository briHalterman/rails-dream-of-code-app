require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /courses/:id" do
    let!(:coding_class) do
      CodingClass.create!(
        title: 'Intro to Programming'
      )
    end

    let!(:trimester) do
      Trimester.create!(
        start_date: Date.today,
        end_date: Date.today + 6.months,
        application_deadline: Date.today - 2.weeks,
        year: Date.today.year,
        term: 'Season'
      )
    end

    let!(:course) do
      Course.create(
        coding_class_id: coding_class.id,
        trimester_id: trimester.id
      )
    end

    let!(:student1) do
      Student.create!(
        first_name: 'Colby',
        last_name: 'Jack',
        email: 'cj@test.com'
      )
    end

    let!(:student2) do
      Student.create!(
        first_name: 'Reggie',
        last_name: 'Ano',
        email: 'ra@test.com'
      )
    end

    let!(:enrollment1) do
      Enrollment.create!(
        course_id: course.id,
        student_id: student1.id
      )
    end

    let!(:enrollment2) do
      Enrollment.create!(
        course_id: course.id,
        student_id: student2.id
      )
    end

    it "responds with 200 OK" do
      get "/courses/#{course.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the course info including enrolled students' do
      get "/courses/#{course.id}"

      # expect(response).to include('Coding class:')
      expect(response.body).to include('Intro to Programming')
      expect(response.body).to include('Trimester:')
      expect(response.body).to include("Season #{Date.today.year}")
      expect(response.body).to include('Enrolled students')
      expect(response.body).to include('Colby Jack')
      expect(response.body).to include('Reggie Ano')
    end
  end
end
