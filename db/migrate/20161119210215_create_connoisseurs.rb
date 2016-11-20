class CreateConnoisseurs < ActiveRecord::Migration[5.0]
  def change
  	create_table :connoisseurs do |t|
  		t.string :username
  		t.string :email
  		t.string :password_digest
  	end
  end
end

