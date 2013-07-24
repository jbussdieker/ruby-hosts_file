require 'hosts_file/parser'

describe HostsFile::Parser do
  def test_example(line, ip, name=nil, *alias_name)
    host = HostsFile::Parser.new(line).first
    host.ip.should eql(ip)
    host.name.should eql(name)
    host.aliases.should eql(alias_name)
  end

  it "should parse multiline" do
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

  it "should handle basic syntax" do
    test_example("1.1.1.1 HOSTNAME", "1.1.1.1", "HOSTNAME")
  end

  it "should handle advanced syntax" do
    test_example("1.1.1.1 HOSTNAME HOST", "1.1.1.1", "HOSTNAME", "HOST")
  end

  it "should support tab separation" do
    test_example("1.1.1.1\tHOSTNAME", "1.1.1.1", "HOSTNAME")
  end

  it "should tolerate lots of tab separation" do
    test_example("1.1.1.1\t\t\t\t\t\t\tHOSTNAME", "1.1.1.1", "HOSTNAME")
  end

  it "should tolerate lots of spaces" do
    test_example("1.1.1.1        HOSTNAME", "1.1.1.1", "HOSTNAME")
  end

  it "should tolerate lots of aliases" do
    test_example("1.1.1.1 HOSTNAME HOSTA HOSTB HOSTC HOSTD", "1.1.1.1", "HOSTNAME", "HOSTA", "HOSTB", "HOSTC", "HOSTD")
  end
end
