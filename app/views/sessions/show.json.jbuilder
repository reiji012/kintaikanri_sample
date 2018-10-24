json.set! :loginUser do
  json.extract! @loginUser, :login_id, :password, :admin
end