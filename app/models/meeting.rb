class Meeting < ApplicationRecord
	#associations
	belongs_to :location
	belongs_to :user
	belongs_to :client

	#validations
	validates :duration, presence: true
	validates :meeting_time, presence: true
end
