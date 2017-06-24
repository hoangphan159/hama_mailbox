class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id, index: true
      t.integer :recipient_id, index: true
      t.text :body
      t.string :status

      t.timestamps
    end
  end
end
