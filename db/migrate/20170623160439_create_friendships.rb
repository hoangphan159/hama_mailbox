class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id, index:true
      t.integer :friend_id, index: true
      t.string :status

      t.timestamps
    end
  end
end
