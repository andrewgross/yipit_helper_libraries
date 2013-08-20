module Yipit
  module Util
    module Vagrant

      include Util

      def self.in_vagrant?(node)
        if Yipit::Util::EC2.in_vpc?(node) || Yipit::Util::EC2.in_ec2?(node)
          return false
        else
          return Yipit::Util.has_nested_key?('vagrant', node)
        end
      end

    end
  end
end