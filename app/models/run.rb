# == Schema Information
#
# Table name: runs
#
#  id            :bigint(8)        not null, primary key
#  strava_run_id :integer
#  distance      :integer
#  date          :datetime
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Run < ApplicationRecord
  belongs_to :user

  validates :strava_run_id, uniqueness: true, allow_blank: true, allow_nil: true
end
