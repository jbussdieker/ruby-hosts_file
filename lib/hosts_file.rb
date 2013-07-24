require "hosts_file/version"
require "hosts_file/file"

module HostsFile
  def self.load(filename = "/etc/hosts")
    File.new(filename)
  end
end
