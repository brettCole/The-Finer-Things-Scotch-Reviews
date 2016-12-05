class Scotch < ActiveRecord::Base
	belongs_to :connoisseur
	validates_presence_of :name, :rating, :price, :review
	
	def slug
		name.downcase.gsub(" ","-")
	end

	def self.find_by_slug(slug)
		Scotch.all.find { |scotch| scotch.slug == slug}
	end

end
