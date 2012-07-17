require 'open-uri'

class Pippin::IPN
  attr_accessor :params, :body

  def initialize(params = {}, body = '')
    @params = parse_dates(params)
    @body   = body
  end

  def valid?
    open(paypal_uri).read == 'VERIFIED'
  end

  private

  def parse_dates(params)
    params.each do |key, value|
      next if key.to_s[/_date$/].nil?

      params[key] = parse_date value
    end
  end

  def parse_date(string)
    return nil if string.blank?

    match = string.match(/(\d+):(\d+):(\d+) (\w{3}) (\d+), (\d{4}) (\w\w\w)/)
    time = Time.zone.local match[6].to_i, match[4],      match[5].to_i,
                           match[1].to_i, match[2].to_i, match[3].to_i

    case match[7]
    when /PDT/
      time + 7.hours + Time.zone.utc_offset
    when /PST/
      time + 8.hours + Time.zone.utc_offset
    end
  end

  def paypal_uri
    domain = 'www.paypal.com'
    domain = 'www.sandbox.paypal.com' if params['test_ipn'] == '1'

    "https://#{domain}/cgi-bin/webscr?cmd=_notify-validate&#{body}"
  end
end
