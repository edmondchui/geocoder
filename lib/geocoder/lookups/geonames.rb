require 'geocoder/lookups/base'
require 'geocoder/results/geonames'

module Geocoder::Lookup
  class Geonames < Base

    def name
      "Geonames"
    end

    def supported_protocols
      [:http]
    end

    def query_url(query)
      "#{protocol}://http://api.geonames.org/findNearestAddressJSON?" + url_query_string(query)
    end

    private # ---------------------------------------------------------------

    def query_url_geonames_params(query)
      params = {}
      if query.reverse_geocode?
        if query.coordinates?
          coordinates = query.coordinates
          params = {:lat => coordinates[0], :lng => coordinates[1]}
        end
      end
      params
    end

    def url_query_string(query)
      query_url_geonames_params(query).merge(
        :username => configuration.username
      ).merge(super)
    end

  end
end
