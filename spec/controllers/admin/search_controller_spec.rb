require 'spec_helper'

describe Admin::SearchController do

  describe "GET 'index'" do
    before(:each) do
      get 'index'
    end
    it { should respond_with :success }
    it { should render_template "index" }
  end

  describe "GET 'show'" do
    it "should return blank list if query param is nil" do
      get 'show'
    end
  end
end
