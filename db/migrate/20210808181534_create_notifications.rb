class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :text
      t.integer :created_at, null: false
      t.integer :updated_at, null: false
    end
  end
end
