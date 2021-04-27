class AddTeamColumnToRound < ActiveRecord::Migration[6.1]
  def change
    add_column :rounds, :team, :integer
  end
end
