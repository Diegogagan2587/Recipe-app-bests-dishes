class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    # if no loggged in we redirect to loggin
    redirect_to new_user_session_path unless user_signed_in?
  end

  def show
    if params[:id] == 'sign_out'
      sign_out current_user
      redirect_to root_path
    end
  end
end
