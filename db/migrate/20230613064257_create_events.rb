class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :event_date
      t.string :location

      t.timestamps
    end
  end
end
