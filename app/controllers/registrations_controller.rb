class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Welcome!"
    else
      flash.now[:alert] = "Try another email address or password."
      render :new, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.expect(user: %i[ email_address password password_confirmation ])
  end
end
