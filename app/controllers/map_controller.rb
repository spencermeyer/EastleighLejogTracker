class MapController < ApplicationController
  def index
    @leader_data=[]
    User.all.each do |u|
      @leader_data << {:screen_name => u.screen_name, :total_miles => u.total_miles}
    end
    @leader_data.sort_by!{ |k| k[:total_miles] }.reverse! 
  end
end
