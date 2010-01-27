module Jambi::RequireExtension
  def require(name, &block)
    puts 'GEMS!' if name =~ /rubygems/i

    return super if name.include? File::SEPARATOR
    gem(name)

    super
  end

  def gem(name, version='> 0')
    version = "= #{version}" if version =~ /^[0-9]/

    if loaded = Jambi.loaded_gems[name]
      unless loaded.version.send(*version.split)
         msg = "can't activate #{name} for #{version}, "
         msg << "already activated #{loaded.full_name}"
         raise Gem::LoadError, msg
      end
      return
    end

    candidates = Jambi.gems_by(name, version)

    return if candidates.empty?

    Jambi.load_gem(candidates.last)
  end
end

