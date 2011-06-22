class Person < ActiveRecord::Base
  include Geokit::Geocoders 

  def after_create
    response = GoogleGeocoder.geocode("#{self.city}, #{self.state}")
    if response.lat && response.lng
      update_attributes(:lat => response.lat, :lng => response.lng)
    end
  end
end
