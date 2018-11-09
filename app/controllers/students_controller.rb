class StudentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_student, only: [:show, :edit, :update, :destroy]

	def index 
		@students = []
		@students = current_user.students if current_user
	end

	def show 
	end 

	def new 
		@student = Student.new 
	end 

	def create
		@student = Student.new(student_params)
		if @student.valid?
			@student.user = current_user
			@client.save
			redirect_to students_path
		end 
	end

	def edit 
	end

	def update 
		@student.update(student_params)
		redirect_to student_path(@student)
	end


	private

	def set_student
		@Student = current_user.students.find_by(id: params[:id])
		if @student.nil?
			flash[:error] = "Student not found."
			redirect_to students_path
		end
	end 

	def student_params
		params.require(:student).permit(:name, :email)
	end
end
