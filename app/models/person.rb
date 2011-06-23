class Person < ActiveRecord::Base
  include Geokit::Geocoders 

  def after_create
    begin
      response = GoogleGeocoder.geocode("#{self.city}, #{self.state}")
      if response.lat && response.lng
        update_attributes(:lat => response.lat, :lng => response.lng)
      end
    rescue Exception => e
      Rails.logger.warn "Failed to geocode #{name}'s lat and lng"
    end
  end

  def shelters
    Shelter.find_all_by_city_and_state(city, state)
  end
end
