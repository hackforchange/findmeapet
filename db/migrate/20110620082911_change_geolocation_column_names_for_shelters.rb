class ChangeGeolocationColumnNamesForShelters < ActiveRecord::Migration
  def self.up
    rename_column :shelters, :latitude, :lat
    rename_column :shelters, :longitude, :lng
  end

  def self.down

    rename_column :shelters, :lng, :longitude
    rename_column :shelters, :lat, :latitude
  end
end
