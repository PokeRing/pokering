class AddIsAdminColumn < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, :after => :bio
  end
end
