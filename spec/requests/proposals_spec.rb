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
        it { should have_content("Name is too short (minimum is 3 characters)") }
        it { should have_content("Description can't be blank") }
        it { should have_content("Description is too short (minimum is 6 characters)") }
      end
      describe "and submits valid information" do
        before do
          fill_in "Name",         with: "Example"
          fill_in "Description",  with: "Description"
          select("Michael Hartl", :from => "response[user_id]")
        end
        it "should create a proposal" do
          expect { click_button submit }.to change(Proposal, :count).by(1)
        end
        describe "after saving the proposal" do
          before { click_button submit }
          let(:proposal) { Proposal.find_by_name('Example') }

          it { should have_selector('h4', text: 'My Proposals') }
          it { should have_link('Home') }
        end
      end
    end
  end
end
