require 'spec_helper'
require 'hosts_file/file'

describe HostsFile::File do
  around(:each) do |example|
    TempDir.create do |dir|
      @dir = dir
      example.run
    end
  end

  it "should handle basic use" do
    file = HostsFile::File.new("")
    file.should be_kind_of(HostsFile::File)
  end

  it "should handle file" do
    test_file = @dir.file("hosts", "1.1.1.1 hostname")
    file = HostsFile::File.new(test_file)
    file.hosts.length.should eql(1)
  end
end
