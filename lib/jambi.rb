
class Jambi
  autoload :Gem,                'jambi/gem'
  autoload :RequireExtension,   'jambi/require_extension'
  autoload :Compat,             'jambi/compat'

  def self.instance
    require 'rbconfig' unless defined? RbConfig
    @instance ||= self.new(RbConfig::CONFIG, :env_path, :user_path, :system_path)
  end

  def initialize(config, *paths)
    @config = config
    @paths = paths
  end

  def engine
    @engine ||= 'ruby'
  end

  def version
    @version ||= @config['ruby_version']
  end

  def dir
    @dir ||= File.join(File.expand_path('~/'), '.jambi')
  end

  def lib_dir
    @lib_dir ||= @config['libdir']
  end

  def system_path
    @system_path ||= File.join(lib_dir, engine, 'gems', version, 'gems')
  end

  def user_path
    @user_path ||= File.join(File.expand_path('~/'), '.gem', engine, version, 'gems')
  end

  def env_path
    return unless ENV['GEM_PATH']
    @env_path ||= File.join(ENV['GEM_PATH'], 'gems')
  end

  def catalogs
    @catalogs ||= @paths.map {|p| respond_to?(p) ? send(p) : p}.compact.map {|p| Jambi::Gem::Catalog.new(p) rescue nil }.compact
  end

  def gems_by_name(name)
    (@gems_by_name ||= {})[name] ||= catalogs.map {|c| c.gems_by_name(name)}.flatten.uniq.sort
  end

  def gems_by(name, version)
    gems_by_name(name).select {|gem| gem.version.send(*version.split)}
  end

  def loaded_gems
    @loaded_gems ||= {}
  end

  def load_gem(gem)
    gem.require_paths.each {|p| $:.unshift(p)}
    loaded_gems[gem.name] = gem
    gem.load_dependencies!
  end
end

if defined? Gem
  Object.send(:remove_const, :Gem)
end
Gem = Jambi::Compat

Object.send(:include, Jambi::RequireExtension)
