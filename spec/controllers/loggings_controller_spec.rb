require 'spec_helper'

describe LoggingsController do

  describe "POST 'create'" do
    before(:each) do
      parse_json_response do
        post 'create', :format => :json, 
          :data => {"event_type" => "tagging", "name" => "riffing"}
      end
    end
    it { should respond_with :success }
    it { @response['status'].should == 'success'}
    it "should write data to the log file" do
      log_file = File.open(File.join(Rails.root, "log", "test_event_log.txt"), "r")
      log_file.read().length.should be > 1
    end
  end
end
