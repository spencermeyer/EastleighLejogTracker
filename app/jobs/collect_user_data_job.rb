class CollectUserDataJob
  @queue = :collect
    
  def self.perform(user_hash)
    user = User.find_by_id(user_hash['id'])

    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: "#general")
    notifier.ping text: "Starting Collect Data Job for #{user['first_name']}"

    before = Time.now.to_i
    after  = (DateTime.new(2019, 1, 1)).to_i

    uri = URI.parse("https://www.strava.com/api/v3/athlete/activities?after=#{after}&before=#{before}&page=1&perPage=100")
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    headers = {"Authorization"=>"Bearer #{user.strava_access_token}"}
    request = Net::HTTP::Get.new(uri, headers)
    response = http.request(request)

    if response.code.to_i == 200
      data = JSON.parse(response.body)

      if user.strava_id == data[0]['athlete']['id']
        data.each do |strava_run|
          run = Run.find_or_create_by(strava_run_id: strava_run['id'])
          run.user_id = user.id
          run.distance = strava_run['distance']
          run.date = Time.zone.parse(strava_run['start_date'])
          run.save
        end
      else
          Rails.logger.log "Mismatch Athlete ID for #{user.id}"
      end

      notifier.ping text: "Sucess Collect Data Job for #{user.first_name}"
    else
      notifier.ping text: "Failed Collect Data Job for #{user.first_name}"
    end
  end
end

# my response:
# a bit big, BUT it is an array of activities.
# here is ONE:

# => [{"resource_state"=>2,
#   "athlete"=>{"id"=>21382538, "resource_state"=>1},
#   "name"=>"API Run",
#   "distance"=>19312.1,
#   "moving_time"=>3600,
#   "elapsed_time"=>3600,
#   "total_elevation_gain"=>2.0,
#   "type"=>"Run",
#   "workout_type"=>nil,
#   "id"=>2068670313,
#   "external_id"=>nil,
#   "upload_id"=>nil,
#   "start_date"=>"2019-01-10T11:30:00Z",
#   "start_date_local"=>"2019-01-10T11:30:00Z",
#   "timezone"=>"(GMT+00:00) Europe/London",
#   "utc_offset"=>0.0,
#   "start_latlng"=>nil,
#   "end_latlng"=>nil,
#   "location_city"=>nil,
#   "location_state"=>nil,
#   "location_country"=>"United Kingdom",
#   "start_latitude"=>nil,
#   "start_longitude"=>nil,
#   "achievement_count"=>0,
#   "kudos_count"=>0,
#   "comment_count"=>0,
#   "athlete_count"=>1,
#   "photo_count"=>0,
#   "map"=>
#    {"id"=>"a2068670313",
#     "summary_polyline"=>nil,
#     "resource_state"=>2},
#   "trainer"=>false,
#   "commute"=>false,
#   "manual"=>true,
#   "private"=>false,
#   "visibility"=>"everyone",
#   "flagged"=>false,
#   "gear_id"=>nil,
#   "from_accepted_tag"=>nil,
#   "average_speed"=>5.364,
#   "max_speed"=>0.0,
#   "has_heartrate"=>false,
#   "heartrate_opt_out"=>false,
#   "display_hide_heartrate_option"=>false,
#   "pr_count"=>0,
#   "total_photo_count"=>0,
#   "has_kudoed"=>false}




