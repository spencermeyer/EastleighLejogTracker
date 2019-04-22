require 'rails_helper'

RSpec.describe StravaWebhookController, type: :controller do
 describe '#webhook' do
  before(:all) do
  end 

  it 'collects user activities' do
    user = create(:user, strava_id: 21382538)

    params = {"aspect_type"=>"create", "event_time"=>1554825872, "object_id"=>2277221429, "object_type"=>"activity", "owner_id"=>21382538, "subscription_id"=>135744, "updates"=>{}, "strava_webhook"=>{"aspect_type"=>"create", "event_time"=>1554825872, "object_id"=>2277221429, "object_type"=>"activity", "owner_id"=>21382538, "subscription_id"=>135744, "updates"=>{}}}

    allow(CollectRunDataJob).to receive(:perform).and_return({something: 'testing'})

    expect{
      post :webhook, :params => params
    }.to change { user.runs.count }.by(1)

    expect(response.code).to eq('200')

    end
  end
end