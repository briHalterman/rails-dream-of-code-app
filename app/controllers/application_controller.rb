# frozen_string_literal: true

class ApplicationController < ActionController::Base # rubocop:disable Style/Documentation
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # If the `role` in session is not admin, set a flash alert message and redirect the user to root
  def require_admin
    if session[:role] != 'admin' # rubocop:disable Style/GuardClause
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_student
    return unless session[:role] != 'student'

    flash[:alert] = 'You do not have access to that page'
    redirect_to root_path
  end
end
