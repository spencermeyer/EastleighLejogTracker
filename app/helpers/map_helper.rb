module MapHelper
  def strava_authorize_request_path
    "https://www.strava.com/oauth/authorize' + '?client_id=' + ENV['STRAVA_CLIENT_ID'] + '&response_type=code' + '&redirect_uri=#{strava_callback_url}/strava_auth&scope=activity:read_all&approval_prompt=force"
  end

  def strava_callback_url
    if Rails.env.production?
      'https://eastleigh-lejog-tracker.herokuapp.com'
    else
      'https://e6102eac.ngrok.io'
    end
  end
end
