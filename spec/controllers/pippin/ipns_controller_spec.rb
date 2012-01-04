require 'spec_helper'

describe Pippin::IpnsController do
  describe '#create' do
    let(:ipn)   { double('IPN') }
    let(:block) { double('block', :call => true) }

    before :each do
      Pippin::IPN.stub :new => ipn
      Pippin.stub :listener => block
    end

    context 'valid IPN' do
      before :each do
        ipn.stub :valid? => true
      end

      it "responds with 200" do
        post :create

        response.status.should == 200
      end

      it "calls the listener with the IPN object" do
        block.should_receive(:call).with(ipn)

        post :create
      end
    end

    context 'invalid IPN' do
      before :each do
        ipn.stub :valid? => false
      end

      it "responds with a 400" do
        post :create

        response.status.should == 400
      end

      it "does not call the listener" do
        block.should_not_receive(:call)

        post :create
      end
    end
  end
end
