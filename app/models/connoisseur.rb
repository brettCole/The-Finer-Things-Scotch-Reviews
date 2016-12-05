class Connoisseur < ActiveRecord::Base
	has_many :scotches
	validates_presence_of :username, :email, :password
	validates_uniqueness_of :username, :email
	has_secure_password

end
