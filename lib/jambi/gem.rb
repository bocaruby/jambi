class Jambi::Gem
  include Comparable

  autoload :Version,      'jambi/gem/version'
  autoload :Catalog,      'jambi/gem/catalog'
  autoload :Specification,'jambi/gem/specification'

  class Exception < RuntimeError; end
  class LoadError < ::LoadError; end

  attr_accessor :dir

  def initialize(dir)
    @dir = dir
  end

  def version
    @version ||= Jambi::Gem::Version.new(full_name.split('-').last)
  end

  def name
    @name ||= full_name.split('-')[0..-2].join('-')
  end

  def full_name
    @full_name ||= File.basename(dir)
  end

  def lib_dir
    @lib_dir ||= File.join(dir, 'lib')
  end

  def spec_path
    @spec_path ||= File.join(dir, '..', '..', 'specifications', "#{full_name}.gemspec")
  end

  def spec
    @spec ||= eval(File.read(spec_path))
  end

  def load_dependencies!
    return if spec.dependencies.empty?
    spec.dependencies.each {|d| gem(*d)}
  end

  def require_paths
    @require_paths ||= spec.require_paths.map {|p| File.join(dir, p)}
  end

  def <=>(other)
    alpha = self.name <=> other.name
    return alpha unless alpha == 0

    self.version <=> other.version
  end
end
