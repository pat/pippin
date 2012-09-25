class Pippin::App
  def call(env)
    request = Rack::Request.new(env)
    ipn     = Pippin::IPN.new request.params, request.body.read

    if ipn.valid?
      Pippin.listener.call ipn if Pippin.listener
      [200, {}, [' ']]
    else
      [400, {}, [' ']]
    end
  end
end
