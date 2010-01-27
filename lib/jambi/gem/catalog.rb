class Jambi::Gem::Catalog
  def initialize(dir)
    @dir = dir
  end

  def gems
    @gems ||= Dir["#{@dir}/*"].map {|p| Gem.new(p)}.sort
  end

  def gems_by_name(name)
    (@gems_by_name ||= {})[name] ||= gems.select {|g| g.name == name}
  end
end
