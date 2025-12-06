class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to after_authentication_url, notice: "Your account was changed.", status: :see_other
    else
      flash.now[:alert] = "The passwords did not match."
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    terminate_session

    Current.user.destroy!

    redirect_to new_session_url, notice: "Your account was removed."
  end

  private

  def set_user
    @user = Current.user
  end

  def user_params
    params.expect(user: %i[ password password_confirmation ])
  end
end
