class LeaderboardController < ApplicationController
  def data
    @data = User.all
    render json: @data
  end
end