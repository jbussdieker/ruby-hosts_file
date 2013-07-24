module HostsFile
  class Parser
    include Enumerable

    def initialize(data)
      @data = data
    end

    def each(&block)
      file_lines.each do |line|
        host = parse_line(line)
        yield(host) if host
      end
    end

private

    def parse_line(line)
      unless line.start_with? "#"
        parts = line.split(" ")
        return nil unless parts.length > 1
        Host.new(parts[0], parts[1], parts[2..-1])
      else
        nil
      end
    end

    def file_lines
      @file_lines ||= @data.split("\n")
    end
  end
end
