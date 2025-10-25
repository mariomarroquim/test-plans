class ChangeTestPlansStepsToReproduceNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :test_plans, :steps_to_reproduce, false
  end
end
