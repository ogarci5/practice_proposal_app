require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe SessionsHelper do
  let(:user) { FactoryGirl.create(:user) }
  describe "sign_in" do
    it "signs in a user" do
      sign_in(user)
      expect(cookies[:remember_token]).to eq(user.remember_token)
    end
  end
  describe "current_user" do
    it "assigns current_user" do
      sign_in(user)
      helper.current_user.should eq(user)
    end
  end
  describe "signed_in?" do
    it "checks if user is authenticated" do
      sign_in(user)
      helper.signed_in?.should eq(true)
    end
  end
  describe "sign_out" do
    it "signs out user" do
      sign_in(user)
      sign_out
      helper.current_user.should eq(nil)
      expect(cookies[:remember_token]).to_not eq(user.remember_token)
    end
  end
end
