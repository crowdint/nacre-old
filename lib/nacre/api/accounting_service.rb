module Nacre
  module API
    class AccountingService < Nacre::API::ServiceResource
      private

      def self.service_url
        '/accounting-service'
      end
    end
  end
end
