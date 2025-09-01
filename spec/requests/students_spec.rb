# Example
# it 'returns a page containing names of all trimesters' do
#   get '/trimesters'
#   expect(response.body).to include('Term 1 2025')
#   expect(response.body).to include('Term 2 2025')
# end

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  describe 'GET /students' do
    context 'students exist' do
      let!(:student) do
        Student.create(
          first_name: 'KJ',
          last_name: 'Loving',
          email: 'kj@test.com'
        )
      end

      let!(:student2) do
        Student.create(
          first_name: 'AJ',
          last_name: 'Suning',
          email: 'aj@test.com'
        )
      end
      it 'returns a page containing names of all students' do
        get '/students'
        expect(response.body).to include('First name:')
        expect(response.body).to include('KJ')
        expect(response.body).to include('AJ')
      end
    end

    context 'students do not exist' do
      it 'returns a page without any student info' do
        get '/students'
        expect(response.body).not_to include('First name:')
      end
    end
  end

  describe 'GET /students/:id', type: :request do
    let!(:student2) do
      Student.create(
        first_name: 'AJ',
        last_name: 'Suning',
        email: 'aj@test.com'
      )
    end

    it 'returns a page containing the info a student' do
      get "/students/#{student2.id}"
      expect(response.body).to include('First name:')
      expect(response.body).to include('AJ')
      expect(response.body).to include('Last name:')
      expect(response.body).to include('Suning')
      expect(response.body).to include('Email:')
      expect(response.body).to include('aj@test.com')
    end
  end

  # describe "GET /students/sorted" do
  #   it 'lists the students alphabetically' do
  #     student1 = Student.create!(first_name: 'Colby', last_name: 'Johnson', email: 'cj@mail.com')
  #     student2 = Student.create!(first_name: 'Reggie', last_name: 'Ano', email: 'ra@mail.com')

  #     get '/students/sorted'

  #     expect(response.body).to include('Johnson, Colby', 'Ano, Reggie')
  #     expect(response.body).to match(/Ano, Reggie.*Johnson, Colby/m)
  #   end

  #   it 'links each name to the student show page' do

  #   end
  # end
end
