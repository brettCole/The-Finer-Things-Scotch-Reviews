class Scotch < ActiveRecord::Base
	belongs_to :connoisseurs
	validates_presence_of :content
end