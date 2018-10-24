class SessionsController < ApplicationController

  def create
    @loginUser = LoginUser.find_by(login_id: params[:loginUser][:login_id])
    puts(params[:loginUser][:login_id])
    if @loginUser && (@loginUser.password == params[:loginUser][:password])
      puts("yes!!!!!!")
			render :json => {loginUser: @loginUser}, status: :created
    else
      puts("sorry!!!!!!")
    end 
  end

end
