class CreateDogs < ActiveRecord::Migration
  def self.up
    create_table :dogs do |t|
      t.integer :shelter_id
=begin
      t.string :url
      t.string :photo_url
=end
      t.string :petharbor_id
      t.string :name
      t.string :color
      t.string :gender
      t.string :breed
      t.integer :age # days
      t.date :brought_to_shelter_at

      t.timestamps
    end
  end

  def self.down
    drop_table :dogs
  end
end
