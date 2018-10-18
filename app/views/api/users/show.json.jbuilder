json.set! :user do
  json.extract! @user, :id, :name, :kana, :amount, :is_done
end