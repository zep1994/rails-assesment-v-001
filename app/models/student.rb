class Student < ApplicationRecord
	#associations
	belongs_to :user
	has_many :meetings
	has_many :locations, through: meetings

	#validations
	validates :name, presence: true
	validates :email, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: 'Please enter a valid email address' }, allow_blank: true
end
