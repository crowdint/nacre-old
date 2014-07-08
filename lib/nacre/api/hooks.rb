require 'nacre'

module Nacre
  module API

    # Set webhooks at Brightpearl
    #
    # == Usage
    # Nacre::Api.new( file: config_file_path ) //authentification
    # hook = Nacre::API::Hooks.new 'www.example.com/product', 'product'
    # hook.set_hook
    #
    # When a products is created/modified/destroyed www.example.com/product is
    # notified with a post with the default_body_template
    #
    # Brightpearl doc http://www.brightpearl.com/developer/latest/concept/webhooks.html
    class Hooks
      def initialize(url, subscribe_to, http_method = 'POST', body_template = true)
        @url = url
        @event = subscribe_to
        @http_method = http_method
        @body_template = body_template ? default_body_template : ''
      end

      def set_hook
        connection.post(post_url, {}, body)
      end

      def self.product_resource(url)
        new(url, 'product.created').set_hook
        new(url + '/${resource-id}', 'product.modified', 'PUT').set_hook
        new(url + '/${resource-id}', 'product.destroyed', 'DELETE', false).set_hook
      end

      def all
        connection.get(post_url)
      end

      def self.all
        response = new('', '').all

        JSON.parse(response.body)['response']
      end

      private

      def default_body_template
        "{\"accountCode\": \"${account-code}\",\"resourceType\": \"${resource-type}\",\"id\": \"${resource-id}\",\"lifecycle-event\": \"${lifecycle-event}\",\"full-event\": \"${full-event}\"}"
      end

      def body
        {
          "subscribeTo" => @event,
          "httpMethod" => @http_method,
          "uriTemplate" =>  @url,
          "bodyTemplate" => @body_template,
          "contentType" => "application/json",
          "idSetAccepted" =>  true
        }
      end

      def connection
        Nacre::Api.global_instance.connection
      end

      def post_url
        '/integration-service/webhook'
      end
    end
  end
end
