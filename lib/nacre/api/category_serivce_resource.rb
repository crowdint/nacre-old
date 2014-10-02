require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre

  module API

    class CategoryServiceResource < Nacre::API::ServiceResource

      include Nacre::API::Searchable

      def self.search(query = nil)
        search = Nacre::API::CategorySearch.new(search_url, query)
        search.results
      end

      private

      def self.service_url
        "/product-service"
      end

    end
  end
end
