class AddExtrainfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    #add_column :users, :avatar, :string, default: 'blank_avatar.png'
  end
end
