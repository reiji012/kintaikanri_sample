class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :kana, null: false
      t.integer :amount,  null: false
      t.boolean :is_done, default: false, null: false

      t.timestamps
    end
  end
end
