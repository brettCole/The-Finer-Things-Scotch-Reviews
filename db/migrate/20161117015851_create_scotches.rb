class CreateScotches < ActiveRecord::Migration[5.0]
  def change
  	create_table :scotches do |t|
  		t.string :name
  		t.string :rating
  		t.string :price
  		t.text :review
  		t.integer :connoisseurs_id
  	end
  end
end
