class Jambi::Gem::Version
  include Comparable
  
  def initialize(version)
    @version = parse_version(version)
  end

  def parse_version(version)
    case version
    when Array
      version.map {|n| Integer(n) rescue n}
    when String
      version.split('.').map {|n| Integer(n) rescue n}
    end
  end

  def major
    @version[0]
  end

  def minor
    @version[1]
  end

  def patch
    @version[2]
  end

  def <=>(other)
    @version.zip(other.to_a).each do |a, b|
      return 1 if a > b
      return -1 if a < b
    end

    return 0
  end

  def to_a
    @version
  end
end
