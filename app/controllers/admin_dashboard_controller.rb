# frozen_string_literal: true

class AdminDashboardController < ApplicationController # rubocop:disable Style/Documentation
  before_action :require_admin

  def index
    @current_trimester = Trimester.where('start_date <= ?', Date.today).where('end_date >= ?', Date.today).first
    @upcoming_trimester = Trimester.where('start_date > ?', Date.today).where('start_date < ?',
                                                                              (Date.today + 6.months)).first
  end
end
