desc "This task is called by the Heroku cron add-on"
# temporarily disable cron:
task :cron => :environment do
  shelter = Shelter.first
  shelter.update_pets
end
