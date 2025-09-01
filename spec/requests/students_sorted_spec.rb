require 'rails_helper'

RSpec.describe "StudentsSorted", type: :request do
  describe "GET /students/sorted" do
    it 'responds with 200 OK' do
      get '/students/sorted'

      expect(response).to have_http_status(:ok)
    end
    context 'students exist' do
      it 'lists the students alphabetically' do
        student1 = Student.create!(first_name: 'Colby', last_name: 'Johnson', email: 'cj@mail.com')
        student2 = Student.create!(first_name: 'Reggie', last_name: 'Ano', email: 'ra@mail.com')

        get '/students/sorted'

        expect(response.body).to include('Johnson, Colby', 'Ano, Reggie')
        expect(response.body).to match(/Ano, Reggie.*Johnson, Colby/m)
      end

      it 'links each name to the student show page' do
        student = Student.create!(first_name: 'Monty', last_name: 'Jack', email: 'mj@mail.com')

        get '/students/sorted'

        expect(response.body).to include("/students/#{student.id}")
      end
    end

    context 'students do not exist' do
      it 'returns a page declaring there are no students' do
        get '/students/sorted'

        expect(response.body).to include('No students yet')
      end
    end
  end
end
