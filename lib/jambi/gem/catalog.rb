class Jambi::Gem::Catalog
  attr_reader :dir

  def initialize(dir)
    raise "Invalid catalog!" if dir.nil?
    @dir = dir
  end

  def gems
    @gems ||= Dir["#{@dir}/*"].map {|p| Jambi::Gem.new(p)}.sort
  end

  def gems_by_name(name)
    (@gems_by_name ||= {})[name] ||= gems.select {|g| g.name == name}
    @gems_by_name[name]
  end
end
