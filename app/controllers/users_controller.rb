class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]

  def upgrade
    if Current.user.admin?
      User.find_by(email_address: params[:email]).update!(paid_at: Date.today)
      redirect_to after_authentication_url, notice: "#{params[:email]}'s account was upgraded to Pro."
    else
      redirect_to after_authentication_url, alert: "You are not authorized to upgrade this account."
    end
  end

  def downgrade
    if Current.user.admin?
      User.find_by(email_address: params[:email]).update!(paid_at: nil)
      redirect_to after_authentication_url, notice: "#{params[:email]}'s account was downgraded to Free."
    else
      redirect_to after_authentication_url, alert: "You are not authorized to downgrade this account."
    end
  end

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
