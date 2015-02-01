class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :organizer_id
      t.string :name
      t.text :location
      t.datetime :date
      t.string :base_game_type
      t.string :game_type
      t.string :limit_type
      t.float :stakes
      t.float :buy_in
      t.float :re_buy_in
      t.float :buy_in_min
      t.float :buy_in_max
      t.integer :min_players
      t.integer :max_players
      t.text :info
      t.text :players
      t.string :status

      t.timestamps
    end
  end
end
