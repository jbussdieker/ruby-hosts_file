require 'hosts_file/parser'
require 'hosts_file/host'

module HostsFile
  class File
    include Enumerable

    def initialize(filename)
      @filename = filename
    end

    # @yield {Host}
    # @return Array<Host>
    def hosts(&block)
      if block_given?
        each(&block)
      else
        collect {|host| host}
      end
    end

    # @yield {Host}
    def each(&block)
      parser.each do |host|
        yield(host)
      end
    end

private

    def parser
      @hosts ||= Parser.new(raw_file)
    end

    def raw_file
      @raw_file ||= ::File.read(@filename)
    end
  end
end
