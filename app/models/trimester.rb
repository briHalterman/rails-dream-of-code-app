# frozen_string_literal: true

class Trimester < ApplicationRecord
  has_many :courses

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :application_deadline, presence: true

  def display_name
    @display_name = "#{term} #{year}"
  end

  private

  def application_deadline_is_valid_date
    if application_deadline.present?
      begin
        Date.parse(application_deadline.to_s)
      rescue ArgumentError
        errors.add(:application_deadline, "date is not in valid format")
      end
    end
  end
end
