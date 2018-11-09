module StudentsHelper

	def student_email(student)
		student.email if student.email != ""
	end

	def student_name(student)
		if current_page?(students_path)
			link_to student.name, student_path(student)
		else
			student.name
		end
	end

end
