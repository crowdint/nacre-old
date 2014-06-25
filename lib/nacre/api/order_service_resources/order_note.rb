require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class OrderNote < OrderServiceResource

      # data:
      #   text      note's text       required
      #   field     id uploaded file
      #   isPublic  note's visibility
      #   addedOn   date note added
      def self.create(order_id, data)
        @order_id = order_id
        response = connection.post(url, {}, data.to_json)
        json_response = JSON.parse(response.body)
        { id: json_response['response'] }
      end

      private

      def self.url
        service_url + "/order/#{@order_id}/note"
      end
    end
  end
end
