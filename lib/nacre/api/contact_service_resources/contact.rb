require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre
  module API
    class Contact < ContactServiceResource

      FIELDS = [
        :id,
        :contactId,
        :firstName,
        :lastName,
        :communication
      ]

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

      def self.url
        service_url + "/contact"
      end
    end
  end
end
