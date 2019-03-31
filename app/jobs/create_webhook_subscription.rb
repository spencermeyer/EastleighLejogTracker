class CreateWebhookSubscription
  def self.perform
    uri = URI.parse("https://api.strava.com/api/v3/push_subscriptions")

    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri)
    request.set_form_data({
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      callback_url: 'https://eastleighlejogtracker.co.uk/strava-webhook',
      verify_token: ENV['STRAVA_VERIFY_TOKEN']
    })

    response = http.request(request)
    Rails.logger.debug response

    # here listen for response which will only come after the 
    # strava_webhook_controller responded in 2 seconds to 
    # the subscription validation request.

    # I am getting "{\"message\":\"Bad Request\",\"errors\":[{\"resource\":\"PushSubscription\",\"field\":\"callback url\",\"code\":\"GET to callback URL does not return 200\"}]}\n"

  end

  def self.view_subscription
    uri = URI.parse("https://api.strava.com/api/v3/push_subscriptions?client_id=#{ENV['STRAVA_CLIENT_ID']}&client_secret=#{ENV['STRAVA_CLIENT_SECRET']}")
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    Rails.logger.debug response
  end

  def self.delete_subscription
    uri = URI.parse("https://api.strava.com/api/v3/push_subscriptions?client_id=#{ENV['STRAVA_CLIENT_ID']}&client_secret=#{ENV['STRAVA_CLIENT_SECRET']}")
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    request = Net::HTTP::Delete.new(uri)
    response = http.request(request)
    Rails.logger.debug response
  end
end
