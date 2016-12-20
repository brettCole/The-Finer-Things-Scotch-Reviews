class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :rating
      t.text :description
      t.integer :scotch_id
      t.integer :connoisseur_id
    end
  end
end
