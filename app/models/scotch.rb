class Scotch < ActiveRecord::Base
	belongs_to :connoisseur
	validates_presence_of :name
	validates_presence_of :rating
	validates_presence_of :price
	validates_presence_of :review

end