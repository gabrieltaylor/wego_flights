require "wego_flights/version"
<<<<<<< HEAD

module WegoFlights
  # Your code goes here...
=======
require "wego_flights/flight"
require "faraday"
require "json"


module WegoFlights
  @api_base = "http://api.wego.com"
  @path = "/flights/api/k/2"

  class << self
    attr_accessor :api_key, :ts_code
  end

  def self.request(method, url, body, params={}, headers={})
    params = {api_key: api_key, ts_code: ts_code}

    conn = Faraday.new(url: "#{@api_base}") do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.post do |req|
      req.url "#{@path}#{url}"
      req.headers['Content-Type'] = 'application/json'
      req.params = params
      req.body = body.to_json
    end
    JSON.parse(response.body)
  end
>>>>>>> add_initial_tests
end
