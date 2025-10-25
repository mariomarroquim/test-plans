class HomeController < ApplicationController
  allow_unauthenticated_access only: :index

  def index
    redirect_to test_plans_url if authenticated?
  end
end
