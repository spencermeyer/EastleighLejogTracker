class Alerter
  class MailGunAlerter
    require 'mailgun-ruby'

    @queue = :email_alert

    def initialize(message)
      @message = message
    end

    def self.perform(message)
      Rails.logger.debug "Alerter will send #{message}"
      begin
        send_simple_message(message)
      rescue StandardError => e
        Rails.logger.debug "alerter problem: #{e}"
      end
    end

    def self.send_simple_message(message_text)
      mg_client = Mailgun::Client.new(ENV['MAILGUNAPIKEY'])

      parameters  = {
        :to      => ENV['LEJOGMAILTARGET'],
        :subject => "An Alert: #{@message}",
        :text    => message_text,
        :from    => 'postmaster@eastleigh-lejog-tracker.herokuapp.com'
      }
      mg_client.send_message 'parkcollectoronrails.co.uk', parameters
    end
  end

  class SlackAlerter
    @queue = :slack_alerter
    require 'slack-notifier'

    def initialize(message)
      @message = message
    end

    def self.perform(message)
      notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: "#general")
      notifier.ping text: "#{message}"
    end
  end
end
