module Jambi::Compat
  RubyGemsVersion = '1.3.1'

  LoadError = Jambi::Gem::LoadError

  def self.source_index
    @source_index ||= SourceIndex.new
  end

  def self.loaded_specs
    {}
  end

  def self.clear_paths
    
  end

  def self.ruby_version
    Jambi.version
  end

  def self.ruby
    'ruby'
  end

  def self.path
    Jambi.catalogs.map {|c| c.dir}
  end

  class Requirement
    attr_reader :version

    def initialize(version)
      @version = version
    end

    def self.default
      self.new('> 0')
    end

    def self.create(version)
      self.new(version)
    end
  end

  class Dependency
    attr_reader :name

    def initialize(name, req)
      @name = name
      @req = req
    end

    def to_a
      [@name, @req.version]
    end

    def version_requirements
      
    end
  end

  class SourceIndex
    def initialize(specs={})
      
    end

    def refresh!
      
    end

    def search(key)
      []
    end
  end

  class Specification
    attr_reader :dependencies

    def initialize
      @info = {}
      @dependencies = []
      yield self
    end

    def add_dependency(name, version)
      @dependencies << [name, version.first]
    end

    def require_paths
      @info['require_paths'] || []
    end

    def method_missing(meth, value)
      @info[meth.to_s.gsub(/=/, '')] = value
    end
  end

  class DependencyList
    def dependency_order
      []
    end
  end
end
