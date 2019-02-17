# == Schema Information
#
# Table name: users
#
#  id                            :bigint(8)        not null, primary key
#  email                         :string           default(""), not null
#  encrypted_password            :string           default(""), not null
#  reset_password_token          :string
#  reset_password_sent_at        :datetime
#  remember_created_at           :datetime
#  sign_in_count                 :integer          default(0), not null
#  current_sign_in_at            :datetime
#  last_sign_in_at               :datetime
#  current_sign_in_ip            :inet
#  last_sign_in_ip               :inet
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  strava_id                     :integer
#  first_name                    :text
#  last_name                     :text
#  screen_name                   :text
#  strava_access_token           :text
#  strava_refresh_token          :text
#  strava_access_token_expiry_in :integer
#  strava_access_token_expiry_at :integer
#  strava_athlete_auth_id        :integer
#  strava_athlete_auth_username  :text
#  strava_athlete_auth_firstname :text
#  strava_athlete_auth_lastname  :text
#  strava_athlete_auth_email     :text
#  admin                         :boolean
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :runs
  belongs_to :team

  def total_miles
    runs.all.sum(:distance).round
  end

  def strava_access_token_expiry_at_human
    DateTime.strptime(strava_access_token_expiry_at.to_s, '%s')
  end
end
