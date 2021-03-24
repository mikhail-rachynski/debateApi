class AddRatingColumnToRound < ActiveRecord::Migration[6.1]
  def change
    add_column :rounds, :rating, :integer
  end
end
