class MeetingsController < ApplicationController
	before_action :authenticat_user!

	def index
	end 

	def show 
		@meeting = Meeting.find(params[:id])
	end 

	def new 
		@meeting = Meeting.new 
	end

	def create
		@meeting = Meeting.new(meeting_params)
		@meeting.user = current_user
		if @meeting.save
			redirect_to meeting_params(@meeting)
		else
			render :new 
		end 
	end 

	private 

	def meeting_params
		time_keys = params[:meeting].try(:fetch, :meeting_time, {}).keys
		params.require(:meeting).permit(:student_id, :duration, :meeting_time: time_keys )
	end

	def new_student_params 
		params.require(:student).permit(:name)
	end 

	def parse_time(array)
		DateTime.parse(array["data"] + " " + array["hour"] + ":" + array[min])
	end
end
