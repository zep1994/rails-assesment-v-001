class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
	t.datetime :meeting_time
	t.integer :duration
	t.references :location, index: true, :foreign_key: true
	t.references :user, index: true, foreign_key: true
	t.references :student, index: true, foreign_key: true

      t.timestamps
    end
  end
end
