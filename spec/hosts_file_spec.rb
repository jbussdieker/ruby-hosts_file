require 'spec_helper'
require 'hosts_file'

describe HostsFile do
  it "should work" do
    hosts = HostsFile.load("")
    hosts.should be_kind_of(HostsFile::File)
  end
end
