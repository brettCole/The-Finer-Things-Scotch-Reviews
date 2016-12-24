class Review < ActiveRecord::Base
  belongs_to :scotch
  belongs_to :connoisseur
  validates :rating, :description, presence: :true
end
