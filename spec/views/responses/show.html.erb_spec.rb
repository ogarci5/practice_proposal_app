require 'spec_helper'

describe "responses/show" do
  before(:each) do
    @response = assign(:response, stub_model(Response))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
