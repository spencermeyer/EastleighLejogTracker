class RefreshTokens
  @queue = :collect
    
  def self.perform
    users = User.where('strava_access_token IS NOT NULL')
              
    users.each_with_index do |user, index|
      Resque.enqueue_at(
        Time.now + (index * 10).seconds,
        RefreshToken, args_hash: {user: user.id} )
    end

    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: "#general")
    notifier.ping text: 'refresh assemble job'
  end
end