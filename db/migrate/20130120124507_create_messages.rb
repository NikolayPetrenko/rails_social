class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.integer :user_id
      t.integer :receiver_id

      t.timestamps
    end
    add_index :messages, :created_at
  end
end
