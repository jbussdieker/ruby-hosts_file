require 'tmpdir'

class TempDir
  attr_accessor :path

  def initialize(root, subpath)
    @path = File.join(root, subpath)
    Dir.mkdir(@path)
  end

  def tree
    #`cd #{@path}; tree -pugAD`
    #`cd #{@path}; find . -printf "%A@ %p\n"`
    `cd #{@path}; find . -printf "%p\n"`
  end

  def mkdir(path)
    Dir.mkdir(File.join(@path, path))
  end

  def file(path, contents)
    filename = File.join(@path, path)
    File.open(filename, 'w') {|f| f.write(contents)}
    filename
  end

  def eql? other
    tree == other.tree
  end

  def to_s
    tree
  end

  def self.create(&block)
    Dir.mktmpdir do |dir|
      yield new(dir, "test")
    end
  end
end
