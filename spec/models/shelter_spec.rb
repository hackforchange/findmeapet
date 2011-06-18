require 'spec_helper'

describe Shelter do
  describe "#update_dogs" do
    before do
      @shelter=Shelter.new
    end
    it "should create 10 dogs the first time" do
      expect { VCR.use_cassette('first_page') { @shelter.update_dogs } }.to change { Dog.count }.by(10)
    end


  end
end