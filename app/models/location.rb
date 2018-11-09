class Location < ApplicationRecord
	#associtations
	has_many :meetings
	has_many :students, through: meetings
end
