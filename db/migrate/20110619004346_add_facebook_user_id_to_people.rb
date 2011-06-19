class AddFacebookUserIdToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :facebook_id, :string
  end

  def self.down
    remove_column :people, :facebook_id
  end
end
