class RemoveRatingAndReviewFromScotchTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :scotches, :rating, :string
    remove_column :scotches, :review, :text
  end
end
