class CreateRings < ActiveRecord::Migration
  def change
    create_table :rings do |t|
      t.string :title
      t.integer :creator_id
      t.string :status
      t.text :users

      t.timestamps
    end
  end
end
