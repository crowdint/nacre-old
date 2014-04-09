require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class ContactServiceResource < Nacre::API::ServiceResource


      private
      def self.service_url
        '/contact-service'
      end
    end
  end
end
