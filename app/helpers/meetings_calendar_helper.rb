module MeetingsCalendarHelper
  def add_weekly_calendar(meetings)
    render partial: "simple_calendar/weekly_calendar_meetings", locals: { meetings: meetings }
  end
  
  def meeting_position(meeting)
    "top: #{ ( ( (meeting.meeting_time - meeting.meeting_time.midnight)/3600 - 8 ) * 40 ) + 28}px;"
  end
  
  def meeting_height(meeting)
    "height: #{meeting.duration * 40/3600}px;"
  end
  
  def at_location(meeting)meeting_time
    " at #{meeting.location_name}" if meeting.location
  end
end