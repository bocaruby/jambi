require 'rbconfig'

class Jambi
  class << self
    def engine
      @engine ||= 'ruby'
    end

    def version
      @version ||= RbConfig::CONFIG['ruby_version']
    end

    def lib_dir
      RbConfig::CONFIG['libdir']
    end

    def path
      @path ||= File.join(lib_dir, engine, 'gems', version, 'gems')
    end

    def gems(name)
      (@gems ||= {})[name] = Dir["#{path}/#{name}*"].map {|p| Gem.new(p)}.sort
    end
  end

  class Gem
    include Comparable

    attr_accessor :dir

    def initialize(dir)
      @dir = dir
    end

    def version
      @version ||= File.basename(dir).split('-').last.split('.').map {|n| n.to_i}
    end

    def <=>(other)
      version.zip(other.version).each do |a, b|
        return 1 if a > b
        return -1 if a < b
      end

      return 0
    end

    def lib_dir
      @lib_dir ||= File.join(dir, 'lib')
    end
  end

  module RequireExtension
    def require(*args, &block)
      candidates = Jambi.gems(args.first)
      return super if candidates.empty?

      if args.size == 1
        $: << candidates.last.lib_dir
      else
      end

      super
    end
  end
end

Gem = Jambi::Gem
Object.send(:include, Jambi::RequireExtension)
