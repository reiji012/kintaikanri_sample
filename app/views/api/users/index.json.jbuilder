json.set! :users do
    json.array! @users do |user|
      json.extract! user, :id, :name, :is_done, :created_at, :updated_at, :kana, :amount
    end
  end