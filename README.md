This cookbook is designed to offer a range of utilities to help you build better
Chef cookbooks.  These are functions that will make it easier to navigate our
infrastructure while avoiding code duplication, and adding a healthy does of TDD
into the mix.

This cookbook will contain nothing but library files.  These files will contain
useful functions to help with things appropriate to their namespace.

To Find out what sort of environment we are in:
```ruby
Yipit::Util::EC2.in_ec2?(node)
Yipit::Util::EC2.in_vpc?(node)
Yipit::Util::Vagrant.in_vagrant?(node)
```

This must can be called by including this cookbook in your `metadata.rb`
dependencies and using the full namespace to reach the method.

# Usage

Simple guard in a recipe to make sure we don't install a package when we are in
the VPC:

```ruby
service "nginx" do
  action :install
  version node['nginx']['version']
  not_if { Yipit::Util::EC2.in_vpc?(node) }
end
```

# Public API

### EC2
```ruby
Yipit::Util::EC2.in_ec2?(node)
Yipit::Util::EC2.in_vpc?(node)
```

### Vagrant
```ruby
Yipit::Util::Vagrant.in_vagrant?(node)
```

### Endpoints
```ruby
Yipit::Util::Endpoint.get_memcache_endpoints
Yipit::Util::Endpoint.get_haystack_endpoints
Yipit::Util::Endpoint.get_redis_endpoints
```

### Logstash
```ruby
Yipit::Util::Logstash.get_search_endpoint(node)
Yipit::Util::Logstash.get_beaver_endpoint(node)
```

### Redis
```ruby
Yipit::Util::Redis.get_redis_endpoint_names
Yipit::Util::Redis.get_specific_redis_endpoint_name(aspect)
Yipit::Util::Redis.get_redis_endpoints
Yipit::Util::Redis.get_specific_redis_endpoint(aspect)
```

### Utility Methods
```ruby
Yipit::Util.has_nested_key?(key,hash)
Yipit::Util.has_indeterminate_key?(key,hash)
Yipit::Util.get_ip_address(node_name)
Yipit::Util.get_accessible_ip(current_node,remote_node)
```

# Contributing

1. Download the repo
2. Run `make install`
3. Run `make test` to make sure everything starts off working
4. Write some code!


Ping
