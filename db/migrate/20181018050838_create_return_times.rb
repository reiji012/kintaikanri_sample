class CreateReturnTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :return_times do |t|
      t.references :user, foreign_key: true
      t.date :return_date, :null, false
      t.integer :difference_amount, :null, false

      t.timestamps
    end
    add_index :return_times, [:user_id, :return_date]
    #Ex:- add_index("admin_users", "username")
  end
end
