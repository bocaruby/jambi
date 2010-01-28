module Jambi::RequireExtension
  def require(name, &block)
    return if name =~ /^rubygems/i

    # Try loading from the original require first
    begin
      return super
    rescue LoadError
    end

    Object.gem(name, '> 0')
  end

end

module Kernel
  def gem(name, version='> 0')
    if name.is_a? Jambi::Compat::Dependency
      name, version = name.to_a
    end

    version = "= #{version}" if version =~ /^[0-9]/

    if loaded = Jambi.loaded_gems[name]
      unless loaded.version.send(*version.split)
         msg = "Can't activate #{name} for #{version}, "
         msg << "already activated #{loaded.full_name}"
         raise Gem::LoadError, msg
      end
      return
    end

    candidates = Jambi.gems_by(name, version)

    if candidates.empty?
      msg = "Could not load '#{name}' "
      msg << "version '#{version}', is it installed?"
      raise Gem::LoadError, msg
    end

    Jambi.load_gem(candidates.last)
  end
end
