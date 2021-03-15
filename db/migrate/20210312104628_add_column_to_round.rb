class AddColumnToRound < ActiveRecord::Migration[6.1]
  def change
    add_column :rounds, :round_type, :integer
  end
end
