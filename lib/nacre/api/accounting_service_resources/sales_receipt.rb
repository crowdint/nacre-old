require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class SalesReceipt < AccountingService
      private
      def self.url
        service_url + '/sales-receipt'
      end
    end
  end
end
