class TestJob
  @queue = :collect
    
  def self.perform(user_hash)
    # binding.pry
    Rails.logger.debug "AWOOGA #{Rails.env}"
    user = User.find(3)

    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: "#general")
    notifier.ping text: "testing"
    Rails.logger.debug "Testing Awooga"
  end
end