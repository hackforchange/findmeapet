require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  test "post stop to stop getting text messages" do
    Person.create(:name => "Corey Testo", :phone => "1234")
    get :receive, "Body" => "stop", "From" => "+11234"
    assert_equal false, Person.first.allow_texts
  end

end
