class AddHashlinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hashlink, :string
  end
end
