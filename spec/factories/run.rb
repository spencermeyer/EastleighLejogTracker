FactoryGirl.define do
  factory(:run) do
    strava_run_id 12345678987654321
    distance 1000  
    user_id 1
  end
end