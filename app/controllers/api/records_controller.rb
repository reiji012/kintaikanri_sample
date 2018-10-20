class Api::RecordsController < ApplicationController
#GET \users
def index
    @records = ReturnTime.order('updated_at ASC')
end

  #POST /users
  def create
			@record = ReturnTime.new(record_params)
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
