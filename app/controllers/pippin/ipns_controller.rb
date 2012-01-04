class Pippin::IpnsController < ActionController::Base
  def create
    if ipn.valid?
      Pippin.listener.call ipn if Pippin.listener
      head :ok
    else
      head :bad_request
    end
  end

  private

  def ipn
    @ipn ||= Pippin::IPN.new params, request.body.read
  end
end
