class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :parent_type
      t.integer :parent_id
      t.integer :commenter_id
      t.text :comment
      t.string :status

      t.timestamps
    end
  end
end
