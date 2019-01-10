class AddStravaDetailsToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :strava_access_token, :text
    add_column :users, :strava_refresh_token, :text
    add_column :users, :strava_access_token_expiry_in, :integer
    add_column :users, :strava_access_token_expiry_at, :integer
    add_column :users, :strava_athlete_auth_id, :integer
    add_column :users, :strava_athlete_auth_username, :text
    add_column :users, :strava_athlete_auth_firstname, :text
    add_column :users, :strava_athlete_auth_lastname, :text
    add_column :users, :strava_athlete_auth_email, :text
  end
end
