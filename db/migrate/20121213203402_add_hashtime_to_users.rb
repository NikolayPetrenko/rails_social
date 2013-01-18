class AddHashtimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hashtime, :timestamp
  end
end
