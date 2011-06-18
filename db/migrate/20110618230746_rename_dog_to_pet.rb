class RenameDogToPet < ActiveRecord::Migration
  def self.up
    rename_table :dogs, :pets
  end

  def self.down
    rename_table :pets, :dogs
  end
end
