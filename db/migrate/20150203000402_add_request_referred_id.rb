class AddRequestReferredId < ActiveRecord::Migration
  def change
    add_column :requests, :referred_id, :integer, :after => :to_id
  end
end
