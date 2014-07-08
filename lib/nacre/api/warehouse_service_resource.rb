require 'nacre'
require 'active_support/inflector'


module Nacre
  module API
    class WarehouseServiceResource < ServiceResource
      def self.service_url
        '/warehouse-service'
      end
    end
  end
end
