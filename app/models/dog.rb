class Dog < ActiveRecord::Base
  validates_uniqueness_of :petharbor_id


end
