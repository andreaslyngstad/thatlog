require "./spec/minitest_lib_helper"
require "./lib/subdomain_login"

describe SubdomainLogin do
   before do
    @sl = SubdomainLogin.new
    @user = "harral"
  end
  describe "sign_in_and_redirect"  do
      it "should sign_in" do
        @sl.sign_in_and_redirect(@user).must_equal "harral"
      end

      it "should redirect to subdomain" do

      end
    end

end