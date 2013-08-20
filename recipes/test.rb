
# Call for Memcache Endpoints
Chef::Log.info(Yipit::Util::Endpoint.get_memcache_endpoints())

# Call for Haystack Endpoints
Chef::Log.info(Yipit::Util::Endpoint.get_haystack_endpoints())

# Call for Redis Endpoints
Chef::Log.info(Yipit::Util::Endpoint.get_haystack_endpoints())

Chef::Log.info(Yipit::Util.get_ip_address("yipit_prod_search"))