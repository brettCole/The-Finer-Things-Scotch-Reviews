class CreateConnoiseor < ActiveRecord::Migration[5.0]
  def change
  	create_table :connoisseors do |t|
  		t.string :username
  		t.string :email
  		t.string :password
  	end
  end
end
