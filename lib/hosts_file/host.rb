module HostsFile
  class Host
    attr_accessor :ip_address, :canonical_hostname, :aliases

    def initialize(ip_address, canonical_hostname, aliases = [])
      @ip_address = ip_address
      @canonical_hostname = canonical_hostname
      @aliases = aliases
    end

    def name
      hostname
    end

    def hostname
      canonical_hostname
    end

    def ip
      ip_address
    end
  end
end
