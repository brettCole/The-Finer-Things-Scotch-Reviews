class Scotch < ActiveRecord::Base
	validates :name, :price, presence: :true
	belongs_to :connoisseur
	has_many :reviews

	def slug
		name.downcase.gsub(" ","-")
	end

	def self.find_by_slug(slug)
		Scotch.all.find { |scotch| scotch.slug == slug }
	end

end
