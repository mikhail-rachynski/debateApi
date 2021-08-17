class CreateUsersNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :users_notifications do |t|
      t.integer :user_id
      t.integer :notification_id
      t.boolean :read, default: false
      t.integer :created_at, null: false
      t.integer :updated_at, null: false
    end
  end
end
