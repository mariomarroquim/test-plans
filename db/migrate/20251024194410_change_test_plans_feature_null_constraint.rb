class ChangeTestPlansFeatureNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :test_plans, :feature, false
  end
end
