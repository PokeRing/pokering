class CreateRings < ActiveRecord::Migration
  def change
    create_table :rings do |t|
      t.integer :creator_id
      t.string :status

      t.timestamps
    end
  end
end
