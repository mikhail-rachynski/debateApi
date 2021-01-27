class CreateGameUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :game_users do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :role
      t.timestamps
    end
  end
end
