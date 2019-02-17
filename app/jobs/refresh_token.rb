class RefreshToken
  @queue = :collect

  def self.perform(hash)
    user = User.find(hash['args_hash']['user'])

    uri = URI.parse("https://www.strava.com/oauth/token?client_id=#{ENV['STRAVA_CLIENT_ID']}&client_secret=#{ENV['STRAVA_CLIENT_SECRET']}&grant_type=refresh_token&refresh_token=#{@user.strava_refresh_token}")
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri)
    response = http.request(request)

    if response.code.to_i == 200
      data = JSON.parse(response.body)
      user.strava_access_token = data['access_token']
      user.strava_refresh_token = data['refresh_token'] 
      user.strava_access_token_expiry_in = data['expires_in']
      user.strava_access_token_expiry_at = data['expires_at']

      user.save

      Resque.enqueue(CollectUserDataJob, user)
    else
      notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: "#general")
      notifier.ping text: "Fail Refresh Token for #{user['first_name']}"      
    end
  end
end
