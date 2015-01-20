require './test/test_helper'

class WegoFlightTest < Minitest::Test

  def test_exists
    assert WegoFlights::Flight
  end

  def test_it_returns_an_array_of_flights
    VCR.use_cassette('flights') do
      trips =  [
        {
          departure_code: "SYD",
          arrival_code: "LON",
          outbound_date: "2015-03-24",
          inbound_date: "2015-03-29"
        }
      ]
      adults_count = 1

      WegoFlights.api_key = "foo"
      WegoFlights.ts_code = "bar"
      query_data = WegoFlights::Flight.search(trips, adults_count)
      print query_data
      assert_equal("KikTzAG7TLax9xTnvBSo2g", query_data[:id])
      assert_equal("SYD:LON:2015-03-24:2015-03-29", query_data[:key])
    end
  end

  def test_it_returns_an_array_of_flight_objects
    VCR.use_cassette('fares') do
      search_id = "KikTzAG7TLax9xTnvBSo2g"
      trip_id = "SYD:LON:2015-03-24:2015-03-29"

      WegoFlights.api_key = "foo"
      WegoFlights.ts_code = "bar"
      fares = WegoFlights::Flight.fares(search_id, trip_id)
    end
  end

  def test_it_gets_the_id_and_key
    response = {"id"=> "KikTzAG7TLax9xTnvBSo2g", "key"=> "[SYD:LON:2015-03-24:2015-03-29]~1~0~US~US"}
    result = WegoFlights::Flight.get_id_and_key(response)
    assert_equal("KikTzAG7TLax9xTnvBSo2g", result[:id])
    assert_equal("SYD:LON:2015-03-24:2015-03-29", result[:key])
  end

end
