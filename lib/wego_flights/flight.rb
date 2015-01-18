module WegoFlights
  class Flight

    attr_reader :id, :make, :model, :year, :color, :vin, :dealer_id
    def initialize(attributes)
      @id = attributes["id"]
      @make = attributes["make"]
      @model = attributes["model"]
      @year = attributes["year"]
      @color = attributes["color"]
      @vin = attributes["vin"]
      @dealer_id = attributes["dealer_id"]
    end

    def self.search(trips, adults_count=1, children_count=0)
      body = { trips: trips, adults_count: adults_count}
      response = WegoFlights.request(:post, "/searches", body)
    end

    def self.fares(search_id, trip_id)
      id = ('a'..'z').to_a.shuffle[0,8].join
      fares_query_type = "route"

      body = {
        id: id,
        search_id: search_id,
        trip_id: trip_id,
        fares_query_type: fares_query_type
      }

      response = WegoFlights.request(:post, "/fares", body)
    end
  end
end
