class AddCityAndStateToShelters < ActiveRecord::Migration
  def self.up
    add_column :shelters, :city, :string, :limit => 32
    add_column :shelters, :state, :string, :limit => 16
  end

  def self.down
    remove_column :shelters, :state
    remove_column :shelters, :city
  end
end
