class CreateScotches < ActiveRecord::Migration[5.0]
  def change
  	create_table :scotches do |t|
  		t.string :name
  		t.integer :rating
  		t.string :price
  		t.string :review
  	end
  end
end
