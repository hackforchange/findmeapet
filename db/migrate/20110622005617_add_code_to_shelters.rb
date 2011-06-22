class AddCodeToShelters < ActiveRecord::Migration
  def self.up
    rename_column :shelters, :shelter_code, :code
  end

  def self.down
    rename_column :shelters, :code, :shelter_code
  end
end
