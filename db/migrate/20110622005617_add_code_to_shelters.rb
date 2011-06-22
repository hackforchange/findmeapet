class AddCodeToShelters < ActiveRecord::Migration
  def self.up
    add_column :shelters, :code, :string, :limit => 8
  end

  def self.down
    remove_column :shelters, :code
  end
end
