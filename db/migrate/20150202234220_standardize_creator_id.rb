class StandardizeCreatorId < ActiveRecord::Migration
  def change
    rename_column :comments, :commenter_id, :creator_id
    rename_column :games, :organizer_id, :creator_id
    add_column :invites, :creator_id, :integer, :after => :parent_id
    rename_column :requests, :requester_id, :creator_id
    add_column :requests, :to_id, :integer, :after => :creator_id
    rename_column :trips, :organizer_id, :creator_id
  end
end
