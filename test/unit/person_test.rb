require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def test_geocodes_location_after_create 
    Person.create(:name => "Test")
  end
end
