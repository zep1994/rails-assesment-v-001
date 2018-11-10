module MeetingsPartialHelper 


	def show_student_name(meeting)
		if current_page?(meetings_path)
			link_to meeting.student_name, meeting_path(meeting)
		else 
			meeting.student_name
		end 
	 end

	 def meeting_heading(meeting)
		if current_page?(meeting_path(meeting))
			content_tag(:h2, show_student_name(meeting))
		else 
			render partial: "meetings/meeting_short", locals: { meeting: meeting}
		end 
	end 


	def meeting_details(meeting)
		if current_page?(meeting_path(meeting))
			link_to meeting.student_name, meeting_path(meeting)
		else
			meeting.student_name
		end 
	end 

	def meeting_UP_links(meeting)
		links = [link_to("Edit", edit_meeting_path(meeting)),
		link_to("Delete", meeting, method: :delete, data: { confirm: "Are you sure you want to delete this meeting?" } )]
		safe_join(links, ", ")
	end 

end 