require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "log in" do
    before {visit login_path }
    
    it {should have_selector("h4", text: "Log in")}
    
    describe "with invalid information" do
      before {click_button "Log in"}
      
      it {should have_selector("h4" text: "Log in")}
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before{valid_login(user)}
      it {should have_selector("h2", text: "Welcome")}
      it {should have_link("Log out", href: logout_path)}
      it {should_not have_link("Log in" href: login_path)}
      
      describe "followed by log out" do
        before { click_link "Sign out" }
        it {should_not have_link("Log out", href: logout_path)}
      end
    end
  end
end