require 'spec_helper'

describe "Users" do
  subject { page }
  
  describe "Users page" do
    before {visit users_path }
    
    it {should have_selector("h1", text: "Listing Users")}
  end
end
