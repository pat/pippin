require 'spec_helper'

describe Pippin::IPN do
  describe '#params' do
    it "should parse dates in params" do
      ipn = Pippin::IPN.new :subscr_date => '20:36:25 Jan 02, 2012 PST'
      ipn.params[:subscr_date].should == Time.zone.local(2012, 1, 3, 4, 36, 25)
    end
  end

  describe '#valid?' do
    let(:ipn)    { Pippin::IPN.new }

    it "checks the validity with PayPal and the given request body" do
      FakeWeb.register_uri :get, /^https:\/\/www\.paypal\.com\/cgi-bin\/webscr/,
        :body => 'VERIFIED'

      ipn = Pippin::IPN.new({}, 'foo=bar')
      ipn.valid?

      FakeWeb.should have_requested(:get,
        'https://www.paypal.com/cgi-bin/webscr?cmd=_notify-validate&foo=bar')
    end

    it "checks the validity in the sandbox if it is a test IPN" do
      FakeWeb.register_uri :get,
        /^https:\/\/www\.sandbox\.paypal\.com\/cgi-bin\/webscr/,
        :body => 'VERIFIED'

      ipn = Pippin::IPN.new({'test_ipn' => '1'}, 'foo=bar')
      ipn.valid?

      FakeWeb.should have_requested(:get,
        'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate&foo=bar')
    end

    it "returns true if PayPal confirms the validity of the data" do
      FakeWeb.register_uri :get, /^https:\/\/www\.paypal\.com\/cgi-bin\/webscr/,
        :body => 'VERIFIED'

      ipn.should be_valid
    end

    it "returns false if PayPal revokes the validity of the data" do
      FakeWeb.register_uri :get, /^https:\/\/www\.paypal\.com\/cgi-bin\/webscr/,
        :body => 'INVALID'

      ipn.should_not be_valid
    end
  end
end
