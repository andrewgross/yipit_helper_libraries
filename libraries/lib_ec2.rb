module Yipit
  module Util
    module EC2

      include Util

      def self.in_ec2?(node)
        Yipit::Util.has_nested_key?('ec2', node)
      end

      def self.in_vpc?(node)
        Yipit::Util.has_nested_key?('vpc_id', node)
      end

    end
  end
end