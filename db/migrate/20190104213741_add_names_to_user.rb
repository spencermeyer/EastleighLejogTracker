class AddNamesToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :first_name, :text 
    add_column :users, :last_name, :text 
    add_column :users, :screen_name, :text 
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name 
    remove_column :users, :screen_name 
  end
end
