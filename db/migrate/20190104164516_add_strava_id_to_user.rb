class AddStravaIdToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :strava_id, :integer 
  end

  def down
    remove_column :users, :strava_id
  end
end
