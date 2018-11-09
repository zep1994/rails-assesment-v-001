class Student < ApplicationRecord
	#associations
	belongs_to :user
	has_many :meetings
	has_many :locations, through: meetings
end
