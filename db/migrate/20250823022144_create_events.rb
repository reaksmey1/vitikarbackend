class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.text :description
      t.string :address
      t.string :location
      t.datetime :event_date
      t.decimal :price
      t.references :organizer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
