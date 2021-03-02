class ChangeColumnStatusInGame < ActiveRecord::Migration[6.1]
  def change
    change_column_default :games, :status, 0
  end
end
