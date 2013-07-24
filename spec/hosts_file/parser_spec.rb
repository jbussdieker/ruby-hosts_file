require 'hosts_file/parser'

describe HostsFile::Parser do
  it "should parse" do
    @parser = HostsFile::Parser.new("1.1.1.1 hostname\n2.2.2.2 hostname2")
    @parser.collect {|h| h}.length.should eql(2)
  end

  it "should not parse comments" do
    @parser = HostsFile::Parser.new("#1.1.1.1 hostname")
    @parser.collect {|h| h}.length.should eql(0)
  end

  it "should not parse invalid lines" do
    @parser = HostsFile::Parser.new("1.1.1.1")
    @parser.collect {|h| h}.length.should eql(0)
  end
end
