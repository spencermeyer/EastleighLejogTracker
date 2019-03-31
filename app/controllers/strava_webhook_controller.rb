class StravaWebhookController < ApplicationController
  require 'net/http'
  def webhook
    # here we listen for events from strava
    # first make sure it has the token
    # first respond to challenge because it is time limited.
    if params['hub.challenge']
      respond_to_strava_validation_request
      Rails.logger.info "Awooga Responded"
    end

    Rails.logger.info "AwoogaX #{request.body.inspect}"
  end

  def respond_to_strava_validation_request
    body = {'hub.challenge': params['hub.challenge']}
    render json: body
  end

  def valid_token?
    params['STRAVA_VERIFY_TOKEN'] == ENV['STRAVA_VERIFY_TOKEN']
  end
end