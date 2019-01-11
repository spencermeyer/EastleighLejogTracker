class CreateRuns < ActiveRecord::Migration[5.1]
  def change
    create_table :runs do |t|
      t.integer :strava_run_id
      t.integer :distance
      t.datetime :date
      t.integer :user_id

      t.timestamps
    end
  end
end
