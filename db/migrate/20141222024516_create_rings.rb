class CreateRings < ActiveRecord::Migration
  def change
    create_table :rings do |t|
      t.string :title
      t.integer :creator_id
      t.text :users
      t.string :status

      t.timestamps
    end
  end
end
