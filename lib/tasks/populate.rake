namespace :db do 
  task :populate => :environment do
    Shelter.find_or_create_by_shelter_code("MIAD",
                                           :title => "Miami-Dade Animal Services",
                                           :lat => '25.813025',
                                           :lng => '-80.134065',
                                           :city => "Miami",
                                           :state => "Florida")

  end
end
