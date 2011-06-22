class AddTitleToShelters < ActiveRecord::Migration
  def self.up
    add_column :shelters, :title, :string, :limit => 24
  end

  def self.down
    remove_column :shelters, :title
  end
end
