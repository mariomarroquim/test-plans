class CreateTestPlans < ActiveRecord::Migration[8.0]
  def change
    create_table :test_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :feature
      t.string :use_case
      t.text :steps_to_reproduce

      t.timestamps
    end
  end
end
