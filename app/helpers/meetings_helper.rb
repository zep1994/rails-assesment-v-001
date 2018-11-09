module MeetingsHelper
	def hour_selector(name, meeting)
		time_choices = {
		     "8 AM" => 8, 
			 "9 AM" => 9, 
			 "10 AM" => 10, 
			 "11 AM" => 11, 
		     "12 PM" => 12, 
		     "1 PM" => 13,
			 "2 PM" => 14,
			 "3 PM" => 15,
			 "4 PM" => 16,
			 "5 PM" => 17,
			 "6 PM" => 18,
		     "7 PM" => 19,
		     "8 PM" => 20,
		 }
         select_tag(name, options_for_select(time_choices, time_choices[meeting_hour(meeting)] ) )
     end

	 def meeting_hour(meeting)
		meeting.meeting_time.strftime('%l %p') if meeting.meeting_time
	 end 



	 def min_selector(name, meeting)
		min_choices = ["00", "15", "30", "45"]
		select_tag(name, options_for_select(min_choices, meeting_min(meeting)))
	 end 

	 def meeting_min(meeting)
		meeting.meeting_time.strftime('%M') if meeting.meeting_time
	 end

	 def duration_field(name)
		options = {
			"30 min" => "1800",
			"45 minutes"=> "2700",
		    "1 hour" => "3600",
            "1 hour and 15 minutes" => "4500",
            "1 hour and 30 minutes" => "5400"
		}

		select_tag(name, options_for_select(options))
	 end 

	 def parse_time(array)
       DateTime.parse(array["date"] + " " + array["hour"] + ":" + array["min"])
     end

	 def meeting_date(meeting)
		 if meeting.meeting_time
			meeting.meeting_time.strftime("%Y-%m-%e")
		 else
			 Time.now.strftime("%Y-%m-%e")
		end
	 end

	 def show_time(meeting)
		meeting.meeting_time.strftime("%A %B %e %l:%M %p")
	 end 

	 def show_student_name(meeting)
		if current_page?(meetings_path)
			link_to meeting.student_name, meeting_path(meeting)
		else 
			meeting.student_name
		end 
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


end
