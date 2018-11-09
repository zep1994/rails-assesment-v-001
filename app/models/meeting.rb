class Meeting < ApplicationRecord
	#associations
	belongs_to :location
	belongs_to :user
	belongs_to :client

	#validations
	validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :meeting_time, presence: true


	
	
	def student_name 
		student.name 
	end 

	def location_name 
		location.name 
	end 

	def meeting_time=(time)
		if time.is_a?(Hash)
			write_attribute(:meeting_time, parse_time(time))
		else
			write_attribute(:meeting_time, time)
		end
	end

	def end_time 
		meeting_time + duration.seconds 
	end 

	def parse_date(string)
		array = string.split("/")
		first = array.pop 
		array.unshift(first).join("-")
	end

	def parse_datetime(hash)
		if hash["date"].match(/\d{2}\/\d{2}\/\d{4}/)
			Time.zone.parse("#{parse_date(hash["date"])} #{hash["hour"]}:#{hash["min"]}")
		 end
	end


	def parse_time(hash)
		DateTime.parse(hash["date"] + " " + hash["hour"] + ":" + hash["min"])
	end  

end
