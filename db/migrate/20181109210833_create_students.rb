class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
	t.string :name
	t.string :phone_number
	t.string :email
	t.references :user, index: true

      t.timestamps
    end
  end
end
