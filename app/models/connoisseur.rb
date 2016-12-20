class Connoisseur < ActiveRecord::Base
	has_secure_password
	has_many :scotches
	has_many :reviews
	validates :username, :email, :password, presence: true
	validates :username, :email, uniqueness: :true
end
