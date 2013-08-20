require 'chef/search/query'

module Yipit
  module Util

    def self.has_nested_key?(key, hash)
      hash = hash.to_hash
      if self.has_indeterminate_key?(key, hash)
        return true
      end

      hash.values.each do |v|
        if v.is_a?(Hash) && self.has_nested_key?(key, v)
          return true
        end
      end

      return false
    end

    def self.has_indeterminate_key?(key, hash)
      if hash.has_key?(key.to_s) || hash.has_key?(key.to_sym)
        return true
      end
    end

    def self.get_ip_address(node_name)
      s = Chef::Search::Query.new
      query = "name:#{node_name}"
      results = s.search(:node, query=query)
      matches = results[0]
      matches.map { |m| m.ipaddress }.first
    end

    def self.get_accessible_ip(current_node, remote_node)
      current_in_vpc = Yipit::Util::EC2.in_vpc?(current_node)
      remote_in_vpc = Yipit::Util::EC2.in_vpc?(remote_node)
      if current_in_vpc == remote_in_vpc
        return remote_node.ipaddress
      elsif current_in_vpc && ! remote_in_vpc
        return remote_node.ec2.public_ipv4
      elsif ! current_in_vpc && remote_in_vpc
        raise "Unable to find path to internal server #{remote_node.name} from #{current_node.name}"
      end
    end

  end
end