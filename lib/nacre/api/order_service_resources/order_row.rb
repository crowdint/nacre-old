require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class OrderRow < OrderServiceResource

      def self.create(order_id, data)
        @order_id = order_id
        response = connection.post(url, {"content-type"=>"application/json"}, data.to_json)
        json_response = JSON.parse(response.body)
        { id: json_response['response'] }
      end

      private

      def self.url
        service_url + "/order/#{@order_id}/row"
      end
    end
  end
end
