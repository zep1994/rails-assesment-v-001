class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
	t.string :name
	t.string :city
	t.string :address
	t.string :state
	t.string :zipcode
	t.references :user, index: true

      t.timestamps
    end
  end
end
