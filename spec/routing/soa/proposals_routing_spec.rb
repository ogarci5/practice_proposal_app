require "spec_helper"

describe Soa::ProposalsController do
  describe "routing" do

    it "routes to #index" do
      get("/soa/proposals").should route_to("soa/proposals#index")
    end

    it "routes to #new" do
      get("/soa/proposals/new").should route_to("soa/proposals#new")
    end

    it "routes to #show" do
      get("/soa/proposals/1").should route_to("soa/proposals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/soa/proposals/1/edit").should route_to("soa/proposals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/soa/proposals").should route_to("soa/proposals#create")
    end

    it "routes to #update" do
      put("/soa/proposals/1").should route_to("soa/proposals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/soa/proposals/1").should route_to("soa/proposals#destroy", :id => "1")
    end

  end
end
