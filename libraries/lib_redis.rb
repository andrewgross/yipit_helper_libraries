require 'chef/data_bag_item'

module Yipit
  module Util
    module Redis

      include Util

      def self.get_redis_endpoint_names
        Chef::DataBagItem.load("mappings", "redis_mappings")['mapping']
      end

      def self.get_specific_redis_endpoint_name(aspect)
        endpoints = self.get_redis_endpoint_names
        unless Yipit::Util.has_indeterminate_key?(aspect, endpoints)
          raise "Unknown redis aspect #{aspect}. Known aspects: #{endpoints.keys}"
        end
        endpoints[aspect]
      end

      def self.get_redis_endpoints
        endpoints = self.get_redis_endpoint_names
        result = {}
        endpoints.each do |k, v|
          result[k] = Yipit::Util.get_ip_address(v)
        end
        result
      end

      def self.get_specific_redis_endpoint(aspect)
        endpoint_name = self.get_specific_redis_endpoint_name(aspect)
        Yipit::Util.get_ip_address(endpoint_name)
      end

    end
  end
end