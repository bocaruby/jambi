module Jambi::RequireExtension
  def require(name, &block)
    # puts "requiring #{name}"
    return if name =~ /^rubygems/i

    return super if name.include? File::SEPARATOR

    begin
      gem(name, '> 0')
    rescue Gem::LoadError
      # swallow this
    end

    super
  end

end

module Kernel
  def gem(name, version='> 0')
    if name.is_a? Jambi::Compat::Dependency
      name, version = name.to_a
    end

    version = "= #{version}" if version =~ /^[0-9]/

    # puts "Loading gem #{name} with version #{version}"
    
    if loaded = Jambi.loaded_gems[name]
      unless loaded.version.send(*version.split)
         msg = "can't activate #{name} for #{version}, "
         msg << "already activated #{loaded.full_name}"
         raise Gem::LoadError, msg
      end
      return
    end

    candidates = Jambi.gems_by(name, version)

    raise Gem::LoadError if candidates.empty?

    Jambi.load_gem(candidates.last)
  end
end
