class AddTestPlansFeatureUseCaseIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :test_plans, %w[feature use_case], name: :index_test_plans_feature_use_case, unique: true
  end
end
