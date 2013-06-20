require 'spec_helper'

describe "responses/edit" do
  before(:each) do
    @response = assign(:response, stub_model(Response))
  end

  it "renders the edit response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => responses_path(@response), :method => "post" do
    end
  end
end
