class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |u|
  		u.string :access_token
  		u.string :access_secret
  		u.string :user_id
  		u.string :screen_name
  		u.timestamps
  	end
  end
end
