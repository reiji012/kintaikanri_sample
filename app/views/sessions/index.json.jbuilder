json.set! :loginUsers do
    json.array! @loginUsers do |loginUser|
      json.extract! loginUser, :login_id, :password, :admin
    end
  end