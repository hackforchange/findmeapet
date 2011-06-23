require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def test_returns_list_of_shelters_this_person_sees
    san_fran = Shelter.create(:city => "San Francisco", :state => "California")
    miami = Shelter.create(:city => "Miami", :state => "Florida")
    person = Person.create(:city => "Miami", :state => "Florida")
    person.shelters.each {|shelter| assert_not_equal san_fran, shelter}
  end

  def test_geocodes_location_after_create 
    Person.create(:name => "Test")
  end
end
