class Connoisseur < ActiveRecord::Base
	has_many :scotches
	has_secure_password

end