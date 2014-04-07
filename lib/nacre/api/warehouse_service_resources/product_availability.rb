require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class ProductAvailability < WarehouseServiceResource
      FIELDS = [:id, :inStock, :onHand, :allocated]

      def self.fields
        FIELDS.map(&:to_s).map(&:underscore).map(&:to_sym)
      end

      fields.each do |attr|
        attr_accessor attr.to_s.underscore.to_sym
      end

      def initialize(values = nil)
        load_values(values) unless values.nil? || values.empty?
      end

      def load_values(values)
        data = values[1]['total']
        self.class.fields.each do |field|
          self.public_send "#{field.to_s}=", data[field.to_s.camelize(:lower)].to_openstruct
        end
        @id = values[0]
      end

      def self.url
        service_url + "/product-availability"
      end
    end
  end
end
