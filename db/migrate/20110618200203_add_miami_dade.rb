class AddMiamiDade < ActiveRecord::Migration
  def self.up
=begin
    Shelter.create(:title => 'Miami-Dade Animal Services', :shelter_code => 'MIAD', :latitude =>'25.813025',
                          :longitude=>'-80.134065')
=end
  end

  def self.down
  end
end
