require 'spec_helper'

describe VideosController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
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
      pending
      get 'show'
      response.should be_success
    end
  end

  describe "PUT 'create'" do
    it "should be successful" do
      pending
      put 'create'
      response.should be_success
    end
  end

  describe "Uploading a video" do
    it "should put a file on the server" do
      #something
    end
  end
end
