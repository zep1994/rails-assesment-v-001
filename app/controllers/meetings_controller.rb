class MeetingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_meeting, only: [:show, :edit, :update, :destroy]

	def index
		@meetings = current_user.meetings
	end 

	def show 
	end 

	def new 
		@meeting = Meeting.new 
	end

	def create
		@meeting = Meeting.new(meeting_params)
		@meeting.user = current_user
		if @meeting.valid?
			@meeting.student = current_user.students.find_or_create_by(new_student_params) if new_student_params[:name] != ""
		    @meeting.save
			redirect_to meeting_params(@meeting)
		else
			@meeting.user = nil
			render :new 
		end 
	end 

	def edit 
	end 

	def udpate 
		if @meeting.update(meeting_params)
			if new_student_params[:name] != ""
				@meeting.student = current_user.students.find_or_create_by(new_student_params)
				@meeting.save 
			end 

			redirect_to meeting_path(@meeting)
		else 
			
			render :edit 
		end 
	end

	private 

	def set_meeting
		@meeting = current_user.meetings.find_or_create_by(id: params[:id])
		if @meeting.nil?
			flash[:error] = "Meeting not found."
			redirect_to meetings_path
		end 
	end

	def meeting_params
		time_keys = params[:meeting].try(:fetch, :meeting_time, {}).keys
		params.require(:meeting).permit(:student_id, :duration, meeting_time: time_keys )
	end

	def new_student_params 
		params.require(:student).permit(:name)
	end 

	def parse_time(array)
		DateTime.parse(array["data"] + " " + array["hour"] + ":" + array[min])
	end
end
