class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :kind
      t.float :score
      t.string :topic
      t.timestamps
    end
  end
end
