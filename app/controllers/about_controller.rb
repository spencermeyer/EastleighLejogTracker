class AboutController < ApplicationController
  def about
  end

  def send_message
    Alerter::MailGunAlerter.perform(params[:message][:message_text])
    redirect_to action: 'about'
  end
end
