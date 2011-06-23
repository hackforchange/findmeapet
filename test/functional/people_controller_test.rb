require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  test "post registration to signup" do
    PeopleController::APP_ID = "blah"
    PeopleController::APP_SECRET = "blah"
    RestGraph.any_instance.stubs(:parse_signed_request!).returns("registration"=>{"name"=>"Corey Grusden", "email"=>"corey.grusden@gmail.com", "location"=>{"name"=>"San Francisco, California", "id"=>114952118516947}, "phone"=>"904-476-6615"}, "registration_metadata"=>{"fields"=>"[{'name':'name'},{'name':'email'},{'name':'location'},\n {'name':'phone', 'description':'Phone Number','type':'text'}]"}, "user"=>{"country"=>"us", "locale"=>"en_US"}, "user_id"=>"208102217")
    post :registration 
    assert 1, Person.count
    assert_not_nil Person.first.phone
    assert_equal "San Francisco", Person.first.city
    assert_equal "California", Person.first.state
    assert_not_nil Person.first.facebook_id
  end

end
