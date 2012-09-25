class Pippin::App
  delegate :instrument, :to => ActiveSupport::Notifications

  def call(env)
    request = Rack::Request.new(env)
    ipn     = Pippin::IPN.new request.params, request.body.read

    if ipn.valid?
      instrument 'received.ipn',                  :ipn => ipn
      instrument "#{ipn.params['txn_type']}.ipn", :ipn => ipn

      [200, {}, [' ']]
    else
      [400, {}, [' ']]
    end
  end
end
