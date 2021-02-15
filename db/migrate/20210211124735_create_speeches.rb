class CreateSpeeches < ActiveRecord::Migration[6.1]
  def change
    create_table :speeches do |t|
      t.integer :user_id
      t.integer :round_id
      t.string :speech
      t.timestamps
    end
  end
end
