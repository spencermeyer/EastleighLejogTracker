class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def strava_access_token_expiry_at_human
    DateTime.strptime(strava_access_token_expiry_at.to_s, '%s')
  end
end
