class CollectRunDataJob
  @queue = :collect
    
  def self.perform(strava_run_id)
    run = Run.find_by_strava_run_id(strava_run_id)
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

      run = Run.find_by_strava_run_id(data['id'])
      run.distance = data['distance']
      run.date = DateTime.parse(data['start_date'])

      run.save!   # unless data['type'] != ????

      # TO DO stop it if it is not a run. (e.g. ride, swim ,etc) need to collect some runs to see how they are marked. Need to log some data to find out how this is formatted.

      Rails.logger.info "AWOOGA #{data} "

      notifier.ping text: "Sucess Collect RUN Job for #{user.first_name}"
    else
      notifier.ping text: "Failed Collect Data Job for #{user.first_name}"
      notifier.ping text: "Error code: #{response.code}"
      notifier.ping text: "#{response.body}"
    end
  end
end


# this works collecting my own runs, but not other users.
# actually it worked for my test user.  Just not Paul.
#   :(
