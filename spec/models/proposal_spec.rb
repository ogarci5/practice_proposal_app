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
  it { should respond_to(:from) }
  it { should respond_to(:user_id) }
  it { should respond_to(:response) }
  it { should respond_to(:name) }
  it { should respond_to(:response_read) }
  it { should respond_to(:reviewed) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { proposal.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too short" do
    before { proposal.name = "hi" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { proposal.name = "x"*41 }
    it { should_not be_valid }
  end
  
  describe "when user_id is not present" do
    before { proposal.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when user_id is not an integer, but is a string" do
    before { proposal.user_id = "sdf" }
    it { should_not be_valid}
  end
  
  describe "when user_id is not an integer, but is a float" do
    before { proposal.user_id = 3.1 }
    it { should_not be_valid }
  end

  

end
