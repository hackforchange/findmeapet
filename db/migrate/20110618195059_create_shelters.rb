class CreateShelters < ActiveRecord::Migration
  def self.up
    create_table :shelters do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :shelter_code

      t.timestamps
    end
  end

  def self.down
    drop_table :shelters
  end
end
