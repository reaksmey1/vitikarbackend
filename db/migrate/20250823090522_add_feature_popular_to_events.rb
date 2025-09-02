class AddFeaturePopularToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :is_feature, :boolean, default: false
    add_column :events, :is_popular, :boolean, default: true
  end
end
