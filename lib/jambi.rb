require 'rbconfig'

module Jambi
  autoload :Gem,                'jambi/gem'
  autoload :RequireExtension,   'jambi/require_extension'
  autoload :Compat,             'jambi/compat'

  def engine
    @engine ||= 'ruby'
  end

  def version
    @version ||= RbConfig::CONFIG['ruby_version']
  end

  def lib_dir
    @lib_dir ||= RbConfig::CONFIG['libdir']
  end

  def system_path
    @system_path ||= File.join(lib_dir, engine, 'gems', version, 'gems')
  end

  def user_path
    @user_path ||= File.join(File.expand_path('~/'), '.gem', engine, version, 'gems')
  end

  def catalogs
    @catalogs ||= [user_path, system_path].map {|p| Jambi::Gem::Catalog.new(p)}
  end

  def gems_by(name, version)
    (@gems ||= {})[name] ||= catalogs.map {|c| c.gems_by_name(name)}.flatten.uniq.sort
    @gems[name].select {|gem| gem.version.send(*version.split)}
  end

  def loaded_gems
    @loaded_gems ||= {}
  end

  def load_gem(gem)
    gem.require_paths.each {|p| $:.unshift(p)}
    loaded_gems[gem.name] = gem
    gem.load_dependencies!
  end

  extend self
end

Gem = Jambi::Compat
Object.send(:include, Jambi::RequireExtension)
