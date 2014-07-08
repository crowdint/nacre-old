require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class Price < ProductServiceResource
      FIELDS = [
        :productId,
        :priceLists
      ]

      def self.update(data, product_id)
        connection.put(update_url(product_id), {"content-type"=>"application/json"}, data.to_json)
      end

      def self.fields
        FIELDS.map(&:to_s).map(&:underscore).map(&:to_sym)
      end

      fields.each do |attr|
        attr_accessor attr.to_s.underscore.to_sym
      end

      def initialize(values = nil)
        load_values(values) unless values.nil? || values.empty?
      end

      private

      def self.update_url(product_id)
        service_url + "/product-price/#{product_id}/price-list"
      end

      def self.url
        service_url + "/product-price"
      end
    end
  end
end
