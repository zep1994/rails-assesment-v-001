class MeetingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_meeting, only: [:show, :edit, :update, :destroy]
	before_action :set_meetings, only: [:index, :show, :edit]
	before_action :set_student, only: [:index, :new, :edit]

	def index
		@upcoming_meetings = current_user.upcoming_meetings
	end 

	def show 
	end 

	def new 
		@meetings = current_user.meetings.select { |m| m.persisted? }
		@meeting = current_user.meetings.build
	end

	def create
		@meeting = Meeting.new(meeting_params.merge(user_id: current_user.id))
		if @meeting.valid?
			@meeting.student = current_user.students.find_or_create_by(new_student_params) if new_student_params[:name] != ""
		    @meeting.save
			redirect_to meeting_path
		else
			@meeting.user = nil
			@meetings = current_user.meetings.select { |m| m.persisted? }
			render :new 
		end 
	end 

	def edit 
	end 

	def udpate 
		if @meeting.update(meeting_params)
			redirect_to meetings_path
		else 
			set_meetings
			render :edit 
		end 
	end

	def destroy  
		@meeting.destroy 
		redirect_to meetings_path 
	end

	private 

	def set_meeting
		@meeting = current_user.meetings.find_or_create_by(id: params[:id])
		if @meeting.nil?
			flash[:error] = "Meeting not found."
			redirect_to meetings_path
		end 
	end

	def set_meetings 
		@meetings = current_user.meetings.order(meeting_time: :desc)
	end 

	def set_student 
		@student = current_user.students.find_by(id: params[:student_id])
	end 

	def meeting_params
		time_keys = params[:meeting].try(:fetch, :meeting_time, {}).keys
		params.require(:meeting).permit(:student_id, :duration, meeting_time: time_keys )
	end

	def new_student_params 
		params.require(:meeting).permit(:client_id, :duration, :location_id, location_attributes: [:nickname], client_attributes: [:name], meeting_time: time_keys)
	end 

	def parse_time(array)
		DateTime.parse(array["data"] + " " + array["hour"] + ":" + array[min])
	end
end
