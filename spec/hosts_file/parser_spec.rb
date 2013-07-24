require 'hosts_file/parser'

describe HostsFile::Parser do
  def test_example(line, ip, name=nil, *alias_name)
    host = HostsFile::Parser.new(line).first
    host.ip.should eql(ip)
    host.name.should eql(name)
    host.aliases.should eql(alias_name)
  end

  def test_case(string, size)
    hp = HostsFile::Parser.new(string)
    hp.collect {|v|v}.length.should eql(size)
  end

  it "should handle a file with only comments" do
    test_case("# TEST", 0)
  end

  it "should handle a file with one host" do
    test_case("1.1.1.1 HOSTNAME", 1)
  end

  it "should handle a basic file" do
    test_case("# TEST\n1.1.1.1 HOSTNAME", 1)
  end

  it "should handle empty lines" do
    test_case("\n\n# TEST\n1.1.1.1 HOSTNAME\n\n", 1)
  end

  it "should handle multiple lines" do
    test_case("1.1.1.1 HOSTNAME\n1.1.1.1 HOSTNAME\n1.1.1.1 HOSTNAME", 3)
  end

  it "should not parse invalid lines" do
    test_case("1.1.1.1\n", 0)
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
