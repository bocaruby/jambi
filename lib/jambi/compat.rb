module Jambi::Compat
  RubyGemsVersion = '1.3.1'

  LoadError = Jambi::Gem::LoadError

  def self.source_index
    @source_index ||= SourceIndex.new
  end

  def self.loaded_specs
    Jambi.loaded_gems.inject({}) do |h, k|
      h[k.first] = k.last.spec
      h
    end
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
    attr_accessor :version_requirements

    def initialize(name, req)
      @name = name
      @req = req
    end

    def to_a
      version = @req.version
      version = "= #{version}" if version =~ /^[0-9]/
      [@name, version]
    end
  end

  class SourceIndex
    def initialize(specs={})
      
    end

    def refresh!
      
    end

    def search(dep)
      Jambi.gems_by(*dep.to_a).map {|g| g.spec}
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

    def files
      @info['files'] || []
    end

    def loaded_from
      ''
    end

    def full_name
      ''
    end

    def full_gem_path
      ''
    end

    def respond_to?(meth)
      meth.to_s =~ /=/ || @info.has_key?(meth.to_s)
    end

    def method_missing(meth, *value)
      if meth.to_s =~ /=/
        return @info[meth.to_s.gsub(/=/, '')] = value.first
      elsif @info.has_key?(meth.to_s)
        return @info[meth.to_s]
      end

      super
    end
  end

  class DependencyList
    def dependency_order
      []
    end

    def add(dep)
      
    end
  end
end