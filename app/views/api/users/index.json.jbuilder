json.set! :users do
    json.array! @users do |user|
      json.extract! user, :id, :name, :is_done, :kana, :amount
    end
  end