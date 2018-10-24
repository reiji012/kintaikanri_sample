class Api::RecordsController < ApplicationController
#GET \users
def index
    @records = ReturnTime.order('return_date ASC')
end

  #POST /users
  def create
		@record = ReturnTime.new(record_params)
		user = @record.user
		if user.return_times.find_by(return_date: record_params[:return_date])
			render :json => {message: "dateDuplicationError"}
			return
		end
		unless @record.amount
			@record.amount = @record.user.amount
		end
    if @record.save
      render :show, status: :created
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
      @record = ReturnTime.find(params[:id])
      if @record.update(record_params)
          render :show, status: :ok
      else
          render json: @record.errors, status: :unprocessable_entity
      end
  end
  
  private

      def record_params
          params.require(:record).permit(
              :user_id, :return_date, :amount
          )
      end
end
