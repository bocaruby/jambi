class Jambi::Gem
  include Comparable

  autoload :Version,  'jambi/gem/version'
  autoload :Catalog,  'jambi/gem/catalog'

  attr_accessor :dir

  def initialize(dir)
    @dir = dir
  end

  def version
    @version ||= Version.new(File.basename(dir).split('-').last)
  end

  def name
    @name ||= File.basename(dir).split('-').first
  end

  def lib_dir
    @lib_dir ||= File.join(dir, 'lib')
  end

  def <=>(other)
    alpha = self.name <=> other.name
    return alpha unless alpha == 0

    self.version <=> other.version
  end
end
