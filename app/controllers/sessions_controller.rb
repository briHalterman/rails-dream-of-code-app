# frozen_string_literal: true

class SessionsController < ApplicationController # rubocop:disable Style/Documentation
  def new; end

  def create
    # 1. Look for a user with the username in the params
    # 2. If a user is found, try to authenticate them with the provided password
    # 3. If authentication is successful, set user info in a session
    # 4. If any of the above fail, return an error to the user and re-render the login form
    # 5. Look for a user with the username in the params (and re-render the form with an error if none is found)

    user = User.find_by(username: params[:username])

    if user
      if user.authenticate(params[:password])
        # Success
        #
      else
        flash.now[:alert] = 'Invalid username or password.'
        render :new
      end
    else
      flash.now[:alert] = 'Invalid username or password.'
      render :new
    end
  end

  def destroy; end
end
