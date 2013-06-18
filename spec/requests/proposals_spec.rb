require 'spec_helper'

describe "Proposals" do
  subject { page }
  describe "- authorized user" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      visit login_path
      valid_login(user)
    end

    describe "views index" do
      before {visit proposals_path}
      it { should have_selector('h4',    text: 'My Proposals') }
      it {should have_content("Sent")}
      it {should have_content("Received")}
    end
    
    describe "views new" do
      before {visit new_proposal_path}
      it {should have_selector('h4', text: "New Proposal")}
      let(:submit) { "Create Proposal" }
      describe "and submits invalid information" do
        before {click_button submit}
        it {should have_selector('h4', text: "New Proposal")}
        it { should have_content("Name can't be blank") }
        it { should have_content("Description can't be blank") }
        it { should have_content("Description is too short (minimum is 6 characters)") }
      end
    end
  end
end
