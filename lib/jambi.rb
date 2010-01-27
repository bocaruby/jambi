require 'rbconfig'

class Jambi
  autoload :Gem,                'jambi/gem'
  autoload :RequireExtension,   'jambi/require_extension'

  class << self
    def engine
      @engine ||= 'ruby'
    end

    def version
      @version ||= RbConfig::CONFIG['ruby_version']
    end

    def lib_dir
      @lib_dir ||= RbConfig::CONFIG['libdir']
    end

    def path
      @path ||= File.join(lib_dir, engine, 'gems', version, 'gems')
    end

    def gems(name)
      (@gems ||= {})[name] = Dir["#{path}/#{name}*"].map {|p| Gem.new(p)}.sort
    end
  end


end

Gem = Jambi::Gem
Object.send(:include, Jambi::RequireExtension)
