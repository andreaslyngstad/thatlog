require 'spec_helper'

describe "Projects" do
  describe "GET /" do
    it "works! (now write some real specs)", :js => true do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get root_path(:subdomain => ("test"))
      response.status.should be(200)
    end
  end
end
