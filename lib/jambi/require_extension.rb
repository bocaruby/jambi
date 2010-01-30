module Jambi::RequireExtension
  def require(name, &block)
    return if name =~ /^rubygems/i

    # Try loading from the original require first
    begin
      return super
    rescue LoadError
    end

    Object.gem(name, '> 0')
    super
  end

end

module Kernel
  def gem(name, version='> 0')
    name, version = name.to_a if name.is_a? Jambi::Compat::Dependency
    version = "= #{version}" if version =~ /^[0-9]/

    jambi = Jambi.instance

    if loaded = jambi.loaded_gems[name]
      unless loaded.version.send(*version.split)
         msg = "Can't activate #{name} for #{version}, "
         msg << "already activated #{loaded.full_name}"
         raise Gem::LoadError, msg
      end
      return
    end

    candidates = jambi.gems_by(name, version)

    if candidates.empty?
      msg = "Could not load '#{name}' "
      msg << "version '#{version}', is it installed?"
      raise Gem::LoadError, msg
    end

    jambi.load_gem(candidates.last)
  end
end
