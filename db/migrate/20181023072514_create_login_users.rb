class CreateLoginUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :login_users do |t|
      t.string :name
      t.string :login_id
      t.string :password
      t.boolean :admin

      t.timestamps
    end
  end
end
