require 'spec_helper'

describe "responses/index" do
  before(:each) do
    assign(:responses, [
      stub_model(Response),
      stub_model(Response)
    ])
  end

  it "renders a list of responses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
