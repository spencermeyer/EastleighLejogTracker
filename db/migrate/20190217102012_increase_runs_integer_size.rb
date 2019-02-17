class IncreaseRunsIntegerSize < ActiveRecord::Migration[5.1]
  def up
    change_column :runs, :strava_run_id, :bigint 
    change_column :runs, :distance, :bigint 
    change_column :runs, :user_id, :bigint 
  end

  def down
    change_column :runs, :strava_run_id, :int
    change_column :runs, :distance, :int
    change_column :runs, :user_id, :int 
  end
end
