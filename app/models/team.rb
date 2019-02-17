class Team < ApplicationRecord
  MAX_PERMITTED_MEMBERS = 4
  has_many :users, before_add: :validate_user_limit

  def full?
    users.size >= MAX_PERMITTED_MEMBERS
  end

  def total_team_miles
    users.all.each.inject(0) { |memo, user| memo + user.total_miles }
  end

  private

  def validate_user_limit(user)
    raise Exception.new if users.size >= MAX_PERMITTED_MEMBERS
  end
end
