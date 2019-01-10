class StravaAuthController < ApplicationController
  require 'net/http'
  require 'net/https'
  require 'uri'
  require 'json'

  def strava_auth
    # Stage 1 listen for authorization from Stava
    code = params[:code]
    scope = params[:scope]
    # Stage 2 use the code to get an auth token
    header = {'Content-Type': 'text/json'}
    uri = URI.parse("https://www.strava.com/oauth/token?client_id=#{ENV['STRAVA_CLIENT_ID']}&client_secret=#{ENV['STRAVA_CLIENT_SECRET']}&code=#{code}&grant_type=authorization_code")
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri)
    response = http.request(request)

    data = JSON.parse(response.body)

    # Stage 3 Save the auth token and start an update job.
    if response.code.to_i == 200
      flash[:success]='Thanks, we are collecting your data, please come back and refresh the page :)'
      current_user=User.where(strava_id: data['athlete']['id']).first
      current_user.strava_access_token = data['access_token']
      current_user.strava_refresh_token = data['refresh_token']
      current_user.strava_access_token_expiry_in = data['expires_in']
      current_user.strava_access_token_expiry_at = data['expires_at']
      current_user.strava_athlete_auth_id = data['athlete']['id']
      current_user.strava_athlete_auth_username = data['athlete']['username']
      current_user.strava_athlete_auth_firstname = data['athlete']['firstname']
      current_user.strava_athlete_auth_lastname = data['athlete']['lastname']
      current_user.strava_athlete_auth_email = data['athlete']['email']
      current_user.save

      Resque.enqueue(CollectUserDataJob, current_user)
    end
    redirect_to root_path
  end

end
