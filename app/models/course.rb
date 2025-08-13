class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  def student_name_list
    student_names = []
    self.enrollments.each do |enrollment|
      student_names << "#{enrollment.student.first_name} #{enrollment.student.last_name}"
    end

    student_names
  end

  def student_email_list
    
  end

  delegate :title, to: :coding_class
end
