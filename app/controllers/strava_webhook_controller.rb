class StravaWebhookController < ApplicationController
  require 'net/http'
  def webhook
    if params['hub.challenge']
      respond_to_strava_validation_request
      Rails.logger.info "Responded to Strava Validation Request"
    end

    if params['aspect_type'] == 'create' && params['object_type'] == 'activity'
      user = User.find_by_strava_id(params['owner_id'])
      run = Run.create(user_id: user.id, strava_run_id: params['object_id'])
      # CollectRunDataJob.perform(run.strava_run_id)
      Resque.enqueue(CollectRunDataJob, run.id)
    end

    Rails.logger.info "AwoogaX #{request.body.inspect}"
    head :ok
  end

  def respond_to_strava_validation_request
    body = {'hub.challenge': params['hub.challenge']}
    render json: body
  end

  def valid_token?
    params['STRAVA_VERIFY_TOKEN'] == ENV['STRAVA_VERIFY_TOKEN']
  end
end

# incoming data from Strava:

# owner_id is the strava account id.

# Processing by StravaWebhookController#webhook as HTML
# I, [2019-04-07T19:14:08.990556 #13092]  INFO -- : [7c8a14a1-2cfa-464e-b721-e4e8b6c37fc1]   Parameters: {"aspect_type"=>"create", "event_time"=>1554664448, "object_id"=>2273162956, "object_type"=>"activity", "owner_id"=>21382538, "subscription_id"=>135744, "updates"=>{}, "strava_webhook"=>{"aspect_type"=>"create", "event_time"=>1554664448, "object_id"=>2273162956, "object_type"=>"activity", "owner_id"=>21382538, "subscription_id"=>135744, "updates"=>{}}}
# I, [2019-04-07T19:14:08.990876 #13092]  INFO -- : [7c8a14a1-2cfa-464e-b721-e4e8b6c37fc1] AwoogaX #<StringIO:0x00000003d4d340>


# Parameters: {"aspect_type"=>"create", "event_time"=>1554825872, "object_id"=>2277221429, "object_type"=>"activity", "owner_id"=>21382538, "subscription_id"=>135744, "updates"=>{}, "strava_webhook"=>{"aspect_type"=>"create", "event_time"=>1554825872, "object_id"=>2277221429, "object_type"=>"activity", "owner_id"=>21382538, "subscription_id"=>135744, "updates"=>{}}}
