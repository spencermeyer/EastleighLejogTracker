class MapController < ApplicationController
  def index
    @leader_data=[]
    User.all.each do |u|
      @leader_data << {:screen_name => u.screen_name, :total_miles => u.total_miles.to_i}
    end
    @leader_data.sort_by!{ |k| k[:total_miles] }.reverse!

    @team_leader_data=[]
    Team.all.each do |t|
      @team_leader_data << {:name => t.name, :total_miles => t.total_team_miles.to_i}
    end
    @team_leader_data.sort_by!{ |k| k[:total_miles] }.reverse!    
  end
end
