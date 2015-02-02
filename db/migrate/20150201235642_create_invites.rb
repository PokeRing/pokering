class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :parent_type
      t.integer :parent_id
      t.integer :invited_id
      t.string :status

      t.timestamps
    end
  end
end
