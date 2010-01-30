class Jambi::Gem::Catalog
  attr_reader :dir

  def initialize(dir)
    raise "Invalid catalog!" if dir.nil? || dir.empty? || !File.exists?(dir)
    @dir = dir
  end

  def gems
    @gems ||= Dir["#{@dir}/*"].map {|p| Jambi::Gem.new(p, self)}.sort
  end

  def gems_by_name(name)
    (@gems_by_name ||= {})[name] ||= gems.select {|g| g.name == name}
    @gems_by_name[name]
  end

  def stat
    @stat ||= File.stat(@dir)
  end

  def updated_at
    @updated_at ||= stat.mtime
  end
end
