class AddUserRatings < ActiveRecord::Migration
  def change
  	add_column :users, :rating, :float, :after => :share
  	create_table :user_ratings do |t|
      t.integer :rating_user_id
      t.integer :rated_user_id
      t.integer :rating

      t.timestamps
    end
  end
end
