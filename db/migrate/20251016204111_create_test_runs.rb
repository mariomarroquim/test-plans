class CreateTestRuns < ActiveRecord::Migration[8.0]
  def change
    create_table :test_runs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test_plan, null: false, foreign_key: true
      t.string :revision
      t.boolean :passed
      t.text :observations

      t.timestamps
    end
  end
end
