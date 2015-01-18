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

      WegoFlights.api_key = "bar"
      WegoFlights.ts_code = "bar"
      flights = WegoFlights::Flight.search(trips, adults_count)
      assert_equal WegoFlights::Flight, flights.class

      # Check that the fields are accessible by our model
      assert_equal 68, car.id
      assert_equal "Honda", car.make
      assert_equal "Civic", car.model
      assert_equal "1996", car.year
      assert_equal "Blue", car.color
      assert_equal "XXXXXXXXXXXXXX", car.vin
      assert_equal 34, car.dealer_id
    end
  end

  def test_it_returns_an_array_of_flight_objects
    VCR.use_cassette('fares') do
      search_id = "KikTzAG7TLax9xTnvBSo2g"
      trip_id = "SYD:LON:2015-03-24:2015-03-29"

      WegoFlights.api_key = "bar"
      WegoFlights.ts_code = "bar"
      fares = WegoFlights::Flight.fares(search_id, trip_id)
    end
  end

end
