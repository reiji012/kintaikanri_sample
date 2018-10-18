json.set! :record do
  json.extract! @record, :user_id, :return_date, :difference_amount
end