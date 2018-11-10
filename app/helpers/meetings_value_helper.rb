module MeetingsValueHelper
	def full_time(meeting)
		meeting.meeting_time.strftime("%A %B %e %l:%M %p")
	end 

	def show_duration 
		meeting.meeting_time.strftime("%b %d, %l:%M %p ")
	end 

	def show_duration(meeting)
		options = {
			 1800 => "30 Minutes", 
			 2700 => "45 Minutes", 
		     3600 => "1 hour", 
		     4500 => "1 hour and 15 minutes",
			 5400 => "1 hour and 30 minutes"
		}

		options[meeting.duration.to_i]
	 end

	 def short_time(meeting)
		meeting.meeting_time.strftime("%b %d, %l:%M %p ")
	 end 

	end

