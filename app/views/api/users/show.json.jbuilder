json.set! :user do
    json.extract! @user, :id, :name, :is_done, :created_at, :updated_at, :kana, :amount
  end