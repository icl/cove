require 'spec_helper'

describe VideosContoller do

  describe "GET 'new'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "Uploading a video" do
    it "should put a file on the server" do
      #something
    end
  end
end
