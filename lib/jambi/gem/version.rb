class Jambi::Gem::Version
  include Comparable
  
  NUMBER_REGEX = /[0-9-]+/

  def initialize(version)
    @version = parse_version(version)

    # pad the version array out to four digits
    @version[3] ||= nil
  end

  def parse_version(version)
    case version
    when Array
      version.map {|n| n =~ NUMBER_REGEX ? n.to_i : n}
    when String
      version.split('.').map {|n| n =~ NUMBER_REGEX ? n.to_i : n}
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

  def normalize_other(other)
     other.is_a?(self.class) ? other : self.class.new(other)
  end

  def to_a
    @version
  end

  def to_s
    to_a.compact.join('.')
  end

  def <=>(other)
    @version.zip(normalize_other(other).to_a).each do |a, b|
      a ||= -1
      b ||= -1
      return 1 if a > b
      return -1 if a < b
    end

    return 0
  end
  
  define_method('~>') do |other|
    self.major == normalize_other(other).major
  end

  define_method('=') do |other|
    self == other
  end

  define_method('!=') do |other|
    !(self == other)
  end
end
