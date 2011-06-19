# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Findmeapet::Application.initialize!

TWILIO = Twilio::RestAccount.new(ENV['ACCOUNT_SID'], ENV['ACCOUNT_TOKEN'])