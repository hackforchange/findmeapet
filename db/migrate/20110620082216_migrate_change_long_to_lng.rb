class MigrateChangeLongToLng < ActiveRecord::Migration
  def self.up
    rename_column :people, :long, :lng
  end

  def self.down
    rename_column :people, :lng, :long
  end
end
