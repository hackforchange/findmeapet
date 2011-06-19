require 'spec_helper'

describe Shelter do
  before do
    @shelter=Shelter.create!
  end
  describe "#update_pets_first_page_only" do
    it "should create 10 pets the first time" do
      expect { VCR.use_cassette('first_page') { @shelter.update_pets_first_page_only } }.to change { Pet.count }.by(10)
    end

  end

  describe "#update_pets" do
    it "should create lots of pets" do
      expect { VCR.use_cassette('all_pages') { @shelter.update_pets } }.to change { Pet.count }.by(185)
      expect { VCR.use_cassette('all_pages') { @shelter.update_pets } }.to_not change { Pet.count }
    end

    it "should add one more pet when a new one shows up" do
      VCR.use_cassette('all_pages') { @shelter.update_pets }
      expect { VCR.use_cassette('all_pages_one_new') { @shelter.update_pets } }.to change { Pet.count }.by(1)
    end
  end
end