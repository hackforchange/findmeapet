class AddImageUri < ActiveRecord::Migration
  def self.up
    add_column :pets, :image_uri, :string
  end

  def self.down
    remove_column :pets, :image_uri
  end
end
