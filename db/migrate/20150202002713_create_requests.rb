class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :parent_type
      t.integer :parent_id
      t.integer :requester_id
      t.string :request_type
      t.string :status

      t.timestamps
    end
  end
end
