require 'spec_helper'

describe Shelter do
  before do
    @shelter=Shelter.new
  end
  describe "#update_dogs_first_page_only" do
    it "should create 10 dogs the first time" do
      expect { VCR.use_cassette('first_page') { @shelter.update_dogs_first_page_only } }.to change { Dog.count }.by(10)
    end

  end

  describe "#update_dogs" do
    it "should create lots of dogs " do
      expect { VCR.use_cassette('all_pages') { @shelter.update_dogs } }.to change { Dog.count }.by(185)
    end

  end
end