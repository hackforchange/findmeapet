class Pet < ActiveRecord::Base
  include ActionController::UrlWriter

  validates_uniqueness_of :petharbor_id
  belongs_to :shelter
  validates_presence_of :shelter

  def image_url
    "http://www.petharbor.com/" + image_uri
  end

  def after_create
    # call twilio if match
    Person.find_all_by_city_and_state(shelter.city, shelter.state).each do |user|
      # send text message:
      t = {
          'From' => "(415) 599-2671",
          'To' => user.phone,
          'Body' => "Dog matched. View: #{pet_url(self, :host => 'findmeapet.heroku.com')}"
      }
      resp = TWILIO.request("/2010-04-01/Accounts/#{ENV['ACCOUNT_SID']}/SMS/Messages",
                            "POST", t)
      raise "Twilio call failed with status code #{resp.code} and body #{resp.body}" unless resp_is_a? Net::HTTPCreated
    end
  end
end
