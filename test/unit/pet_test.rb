require 'test_helper'

class PetTest < ActiveSupport::TestCase
  def test_image_uri_is_returned
    shelter = Shelter.create(:code => "MIAD")
    pet = Pet.new(:petharbor_id => "ADSF", :shelter => shelter)
    assert_not_nil pet.image_url
  end
end
