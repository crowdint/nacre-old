require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class PostalAddress < ContactServiceResource

      def self.create(data)
        response = connection.post(url, {}, data.to_json)
        json_response = JSON(response.body)
        { id: json_response['response'] }
      end

      private

      def self.connection
        Nacre::Api.global_instance.connection
      end

      def self.url
        service_url + '/postal-address'
      end

    end
  end
end

