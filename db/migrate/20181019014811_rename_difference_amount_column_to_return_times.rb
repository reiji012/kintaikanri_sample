class RenameDifferenceAmountColumnToReturnTimes < ActiveRecord::Migration[5.2]
  def change
    rename_column :return_times, :difference_amount, :amount
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
