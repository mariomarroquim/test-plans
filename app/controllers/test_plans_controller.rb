class TestPlansController < ApplicationController
  before_action :set_test_plan, only: %i[ show edit update destroy ]

  def index
    scope = Current.user.test_plans.order(feature: :asc)

    search = params[:search]&.squish&.strip

    if search.blank?
      @test_plans = scope.all
    else
      @test_plans = scope
        .where("feature LIKE ? OR use_case LIKE ? OR steps_to_reproduce LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%").all
    end

    if !Current.user.unlimited_test_plans?
      flash.now[:alert] = User::UPGRADE_TO_PRO_MESSAGE
    end
  end

  def show
    @test_runs = @test_plan.test_runs.order(id: :desc).all
  end

  def new
    flash.now[:info] = "Please, avoid using Production data. Use only testing data."

    if params[:test_plan_id].present?
      original_test_plan = Current.user.test_plans.find(params[:test_plan_id])
      @test_plan = original_test_plan.dup
    else
      @test_plan = Current.user.test_plans.new
    end
  end

  def edit
  end

  def create
    @test_plan = Current.user.test_plans.new(test_plan_params)

    if @test_plan.save
      redirect_to @test_plan, notice: "Test plan was successfully created."
    else
      flash.now[:alert] = "#{@test_plan.errors.full_messages.join(", ").html_safe}."
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @test_plan.update(test_plan_params)
      redirect_to @test_plan, notice: "Test plan was successfully updated.", status: :see_other
    else
      flash.now[:alert] = "#{@test_plan.errors.full_messages.join(", ")}."
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @test_plan.destroy!
    redirect_to test_plans_path, notice: "Test plan was successfully destroyed.", status: :see_other
  end

  private

  def set_test_plan
    @test_plan = Current.user.test_plans.find(params.expect(:id))
  end

  def test_plan_params
    params.expect(test_plan: [ :feature, :use_case, :steps_to_reproduce ])
  end
end
