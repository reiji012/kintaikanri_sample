class Api::UsersController < ApplicationController

    #GET \users
    def index
      @users = User.order('kana ASC')
		end

	#POST /users
	def create
		@user = User.new(user_params)

		if @user.save
			render :show, status: :created
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /users/1
	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			render :show, status: :ok
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end
	
	private

		def user_params
			params.require(:user).permit(
				:name, :kana, :amount, :is_done
			)
		end
		
end
