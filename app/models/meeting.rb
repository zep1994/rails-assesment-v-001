class Meeting < ApplicationRecord
	#associations
	belongs_to :location
	belongs_to :user
	belongs_to :client

	#validations
	validates :duration, presence: true
	validates :meeting_time, presence: true


	def date 
	end 

	def student_name 
		student.name 
	end 

	def location_name 
		location.name 
	end 

	def meeting_time=(time)
		write_attribute(:meeting_time, parse_time(time))
	end

	def parse_time(hash)
		DateTime.parse(hash["date"] + " " + hash["hour"] + ":" + hash["min"])
	end  

end
