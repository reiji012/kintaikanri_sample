class Api::RecordsController < ApplicationController
#GET \users
def index
    @records = ReturnTime.order('return_date ASC')
end

  #POST /users
	def create
		puts record_params
		puts "hey"
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

  # PATCH/PUT /records/1
	def update
	
		for records in params[:_json] do
		@record = ReturnTime.find_by(id: records[:id])
			puts @record
			record = records.permit(
           :amount
          )
      if @record.update_attributes(record)
          render :show, status: :ok
      else
          render json: @record.errors, status: :unprocessable_entity
			end
			
		end

  end
  
	private
	
		def record_params
				params.require(:record).permit(
						:user_id, :return_date, :amount
				)
		end
end
