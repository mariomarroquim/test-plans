class TestRunsController < ApplicationController
  before_action :set_test_run, only: %i[ show edit update destroy ]

  def show
  end

  def new
    @test_run = Current.user.test_runs.new(test_plan_id: params.expect(:test_plan_id))
  end

  def edit
  end

  def create
    @test_run = Current.user.test_runs.new(test_run_params)

    if @test_run.save
      redirect_to @test_run, notice: "Test run was successfully created."
    else
      flash.now[:alert] = "#{@test_run.errors.full_messages.join(", ")}."
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @test_run.update(test_run_params)
      redirect_to @test_run, notice: "Test run was successfully updated.", status: :see_other
    else
      flash.now[:alert] = "#{@test_run.errors.full_messages.join(", ")}."
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @test_run.destroy!
    redirect_to @test_run.test_plan, notice: "Test run was successfully destroyed.", status: :see_other
  end

  private

  def set_test_run
    @test_run = Current.user.test_runs.find(params.expect(:id))
  end

  def test_run_params
    params.expect(test_run: [ :test_plan_id, :revision, :passed, :observations ])
  end
end
