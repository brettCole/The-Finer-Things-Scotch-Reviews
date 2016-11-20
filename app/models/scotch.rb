class Scotch < ActiveRecord::Base
	belongs_to :connoisseurs
	validates_presence_of :name
	validates_presence_of :rating
	validates_presence_of :review
end