require 'spec_helper'

describe Admin::SearchController do

  describe "GET 'show'" do
    it "should return all the videos if no query" do
      get 'show'
      assigns[:results].should == Video.all
    end
  end
end
