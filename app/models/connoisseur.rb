class Connoisseur < ActiveRecord::Base
	has_many :scotches
	#validates_presence_of :username, :email, :password
	validates_uniqueness_of :username, :email
	validates_presence_of :username, :email, :password, presence: {message: "fields can't be blank"}
	has_secure_password

end
