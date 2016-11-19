class Connoisseur < ActiveRecord::Base
	has_many :scotches
	has_secure_password

	def slug
		slug = username.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		Connoisseur.all.detect { |connoisseur| connoisseur.slug == slug }
	end
end