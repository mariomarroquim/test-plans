class ChangeTestPlansUseCaseNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :test_plans, :use_case, false
  end
end
