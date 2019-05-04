require 'rails_helper'
require 'webmock/rspec'

RSpec.describe CollectRunDataJob do
  describe '#perform' do
    it 'receives run information and stores it' do
      user = create(:user, strava_id: 21382538)
      run = create(:run, user_id: user.id, strava_run_id: 12345678987654321)
      slack_notifier = Slack::Notifier.new('foobar')

      body_text = File.open('spec/jobs/collect_data_sample_response.txt')
      body = ''
      body_text.each_line { |line| body << line   }

      body_json = JSON.parse(body)

      allow(Slack::Notifier).to receive(:new).and_return(slack_notifier)
      allow(slack_notifier).to receive(:ping)

      stub_request(:get, "https://www.strava.com/api/v3/activities/12345678987654321").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer',
          'Host'=>'www.strava.com',
          'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: JSON.generate(body_json), headers: {"Content-Type"=> "application/json"})

      #TODO change the activity type to run in the sample data
      #  use rspec to optimise the logging in the controller.

      described_class.perform(run.strava_run_id)

      expect(user.runs.count).to eq(1)
      expect(user.runs.first.distance).to eq(28099)
      expect(user.runs.first.date).to eq(DateTime.parse('Fri, 16 Feb 2018 14:52:54 +0000'))
    end
  end
end
