class CreateParts < ActiveRecord::Migration
  def change
  	create_table :parts do |t|
  		t.string :name
  		t.integer :price
  		t.integer :build_id
  	end
  end
end
