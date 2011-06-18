class Pet < ActiveRecord::Base
  validates_uniqueness_of :petharbor_id

  def image_url
    "http://www.petharbor.com/" + image_uri
  end
end
