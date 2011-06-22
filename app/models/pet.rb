class Pet < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  validates_uniqueness_of :petharbor_id
  belongs_to :shelter
  validates_presence_of :shelter
  after_create :send_texts_if_match

  SHELTER_IMAGE_URI_PREFIX = {'MIAD' => "http://www.petharbor.com/"}

  def image_url
    "#{SHELTER_IMAGE_URI_PREFIX[shelter.shelter_code]}#{image_uri}"
  end

  def send_texts_if_match
    # call twilio if match
    Person.find_all_by_city_and_state_and_allow_texts(shelter.city, shelter.state, true).each do |user|
      # send text message:
      t = {
          'From' => ENV["CALLER_ID"],
          'To' => user.phone,
          'Body' => "Dog matched. View: #{pet_url(self, :host => 'findmeapet.heroku.com')}"
      }
      resp = TWILIO.request("/2010-04-01/Accounts/#{ENV['ACCOUNT_SID']}/SMS/Messages",
                            "POST", t)
      raise "Twilio call failed with status code #{resp.code} and body #{resp.body}" unless resp.is_a? Net::HTTPCreated
    end
  end
end
