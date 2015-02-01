class AddShareColumn < ActiveRecord::Migration
  def change
    add_column :users, :share, :string, :after => :bio
  end
end
