module Jambi::RequireExtension
  def require(name, &block)
    return super if name.include? File::SEPARATOR
    gem(name)

    super
  end

  def gem(name, version='> 0')
    return if Jambi.loaded_gems[name]

    version = "= #{version}" if version =~ /^[0-9]/
    candidates = Jambi.gems_by(name, version)

    return if candidates.empty?

    Jambi.load_gem(candidates.last)
  end
end

