class ChangeTestRunsPassedNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :test_runs, :passed, false
  end
end
