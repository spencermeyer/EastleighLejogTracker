class UserSerializer < ActiveModel::Serializer
  attributes :screen_name, :total_miles

  def total_miles
    self.object.total_miles/1609
  end
end
