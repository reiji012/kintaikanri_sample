json.set! :records do
    json.array! @records do |record|
      json.extract! record, :id, :user_id, :return_date, :amount
    end
  end