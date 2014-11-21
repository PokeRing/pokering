class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :pin_salt
      t.string :pin_encrypted
      t.string :favorite_hand
      t.string :avatar_url
      t.string :phone
      t.string :city
      t.string :state
      t.string :notify_via
      t.text :bio
      t.string :status

      t.timestamps
    end
  end
end
