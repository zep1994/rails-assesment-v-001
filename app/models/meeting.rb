class Meeting < ApplicationRecord
	#associations
	belongs_to :location
	belongs_to :user
	belongs_to :student

	accepts_nested_attributes_for :student

	#validations
	validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :meeting_time, presence: true
	validates :student_id, presence: true

	
	
	def start_time 
		self.meeting_time 
	end

	def student_name 
		student.name 
	end 

	def student_attributes=(args)
		if args[:name] != ""
			self.student = self.user.students.find_or_create_by(args)
		end 
	end 

	def location_name 
		location.name 
	end 

	 def meeting_time=(time)
    if time.is_a?(Hash)
      self[:meeting_time] = parse_datetime(time) 
    else
      self[:meeting_time] = time
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

    def duration=(duration) 
      if duration.is_a?(Hash)
       self[:duration] = parse_duration(duration)
      else 
        self[:duration] = duration
      end
    end
  
    def parse_duration(hash)
      hash["hour"].to_i + hash["min"].to_i
    end

	def parse_time(hash)
		 DateTime.parse(parse_date(hash["date"]) + " " + hash["hour"] + ":" + hash["min"])
	end  

end
