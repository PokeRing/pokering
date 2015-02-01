class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :organizer_id
      t.text :location
      t.datetime :arrival_date
      t.datetime :departure_date
      t.boolean :is_chop_room
      t.integer :max_players
      t.text :players
      t.boolean :notify_rings
      t.string :status

      t.timestamps
    end
  end
end
