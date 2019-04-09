class CollectRunDataJob
  @queue = :collect
    
  def self.perform(run_id)
    run = Run.find(run_id)
    user = User.find(run.user_id)

    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: "#general")
    notifier.ping text: "Starting Collect Run Job for #{user.first_name}"

    uri = URI.parse("https://www.strava.com/api/v3/activities/#{run.strava_run_id}")

    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    headers = {"Authorization"=>"Bearer #{user.strava_access_token}"}
    request = Net::HTTP::Get.new(uri, headers)
    response = http.request(request)

    if response.code.to_i == 200
      data = JSON.parse(response.body)
      # here parse the data and populate the run.

      notifier.ping text: "Sucess Collect RUN Job for #{user.first_name}"
    else
      notifier.ping text: "Failed Collect Data Job for #{user.first_name}"
      notifier.ping text: "Error code: #{response.code}"
      notifier.ping text: "#{response.body}"
    end
  end
end
