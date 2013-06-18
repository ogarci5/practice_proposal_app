# == Schema Information
#
# Table name: proposals
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Proposal do
  
  let(:proposal) { FactoryGirl.create(:proposal) }
  
  subject { proposal }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { proposal.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too short" do
    before { proposal.name = "xx" }
    it { should_not be_valid }
  end
  
  describe "when name is too long " do
    before { proposal.name = "x"*41 }
    it { should_not be_valid }
  end
  
  describe "when user_id is not present" do
    before { proposal.user_id = " " }
    it { should_not be_valid }
  end
  
  describe "when user_id is not an integer" do
    before { proposal.user_id = "xxx"}
    it { should_not be_kind_of(Integer) }
  end
  
  describe "when description is not present" do
    before { proposal.description = " " }
    it { should_not be_valid }
  end
  
  describe "when description is too short" do
    before { proposal.description = "aa" }
    it { should_not be_valid }
  end
  
end
