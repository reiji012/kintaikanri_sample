class AddAmountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :amount, :integer, null: false
  end
end
