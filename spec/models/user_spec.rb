# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
 
  let(:user) { FactoryGirl.create(:user) }
  
  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_digest) }

  it { should be_valid }
  
  describe "when email address is not unique" do
    before do
      @user_with_same_email = user.dup              # NOTE: must be @ varialble to use in 'it' block
      @user_with_same_email.email = user.email.upcase
    end
    
    # re the following test: the index on :email enforces uniqueness at the database level. THis
    # is necessesary b/c the uniqueness validation can fail in the case of two new records 
    # created in rapid succession. So: if a record with a duplicate email is saved, then an
    # error will be thrown before rspec gets a chance to validate it, hence the odd construction 
    # of the following 'it' block. 
    it { lambda { @user_with_same_email.save }.should raise_error }
  end
end
