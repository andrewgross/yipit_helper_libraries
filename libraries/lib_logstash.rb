require 'chef/search/query'

module Yipit
  module Util
    module Logstash

      include Util

      def self.get_search_endpoint(node)
        result = nil
        s = Chef::Search::Query.new
        q = "role:*log_search*"
        search_nodes = s.search(:node, q).first
        search_nodes.each do |search_node|
          if Yipit::Util::EC2.in_vpc?(node) == Yipit::Util::EC2.in_vpc?(search_node)
            result = { :host => Yipit::Util.get_accessible_ip(node, search_node),
                       :cluster => search_node.elasticsearch.cluster_name
                     }
          end
        end
        return result
      end

      def self.get_beaver_endpoint(node)
        result = nil
        s = Chef::Search::Query.new
        q = "role:*logstash*"
        search_nodes = s.search(:node, q).first
        search_nodes.each do |search_node|
          if Yipit::Util::EC2.in_vpc?(node) == Yipit::Util::EC2.in_vpc?(search_node)
            result = Yipit::Util.get_accessible_ip(node, search_node)
          end
        end
        return result
      end

      def self.get_graphite_endpoint(node)
        result = nil
        s = Chef::Search::Query.new
        q = "role:*graphite*"
        search_nodes = s.search(:node, q).first
        search_nodes.each do |search_node|
          if Yipit::Util::EC2.in_vpc?(node) == Yipit::Util::EC2.in_vpc?(search_node)
            result = Yipit::Util.get_accessible_ip(node, search_node)
          end
        end
        return result
      end

    end
  end
end