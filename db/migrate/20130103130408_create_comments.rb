class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :user_id
      t.integer :side_id
      t.integer :pid

      t.timestamps
    end
    add_index :comments, :created_at
  end
end
