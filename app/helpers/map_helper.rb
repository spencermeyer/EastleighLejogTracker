module MapHelper
  def strava_authorize_request_path
    'https://www.strava.com/oauth/authorize' + '?client_id=' + ENV['STRAVA_CLIENT_ID'] + '&response_type=code' + '&redirect_uri=https://fa5fda02.ngrok.io/strava_auth&scope=activity:read_all&approval_prompt=force'
  end
end
