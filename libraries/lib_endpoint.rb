require 'chef/data_bag_item'

module Yipit
  module Util
    module Endpoint

      def self.get_memcache_endpoints()
        Chef::DataBagItem.load("mappings", "memcache_mappings")['cache_locations']
      end

      def self.get_haystack_endpoints()
        Chef::DataBagItem.load("mappings", "haystack_mappings")['server_location']
      end

      def self.get_redis_endpoints()
        Yipit::Util::Redis.get_redis_endpoints()
      end


    end
  end
end