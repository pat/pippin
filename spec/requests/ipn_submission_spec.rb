require 'spec_helper'

describe 'IPN Submission' do
  context 'valid IPN' do
    before :each do
      FakeWeb.register_uri :get, /^https:\/\/www\.paypal\.com\/cgi-bin\/webscr/,
        :body => 'VERIFIED'
    end

    it "responds with a 200 status" do
      post '/pippin/ipns'

      response.status.should == 200
    end

    it "calls the provided listener" do
      ipn_lodged = false
      Pippin.listener = lambda { |ipn| ipn_lodged = true }

      post '/pippin/ipns'

      ipn_lodged.should be_true
    end
  end

  context 'invalid IPN' do
    before :each do
      FakeWeb.register_uri :get, /^https:\/\/www\.paypal\.com\/cgi-bin\/webscr/,
        :body => 'INVALID'
    end

    it "responds with a 400 status" do
      post '/pippin/ipns'

      response.status.should == 400
    end

    it "does not call the provided listener" do
      ipn_lodged = false
      Pippin.listener = lambda { |ipn| ipn_lodged = true }

      post '/pippin/ipns'

      ipn_lodged.should be_false
    end
  end
end
