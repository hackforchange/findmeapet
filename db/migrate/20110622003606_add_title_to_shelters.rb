class AddTitleToShelters < ActiveRecord::Migration
  def self.up
    add_column :shelters, :title, :string
  end

  def self.down
    remove_column :shelters, :title
  end
end
