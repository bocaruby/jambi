require File.dirname(__FILE__) + '/test_helper'

class VersionTest < Test::Unit::TestCase
  def setup
    @version = Jambi::Gem::Version.new('1.2.3')
  end

  def test_responds_to_major
    assert_equal 1, @version.major
  end

  def test_responds_to_minor
    assert_equal 2, @version.minor
  end

  def test_responds_to_patch
    assert_equal 3, @version.patch
  end

  def test_handles_greater_than_camparison
    assert @version > Jambi::Gem::Version.new('1.0.0')
  end

  def test_handles_less_than_comparison
    assert @version < Jambi::Gem::Version.new('1.5.0')
  end

  def test_handles_equals_to_comparison
    assert @version == Jambi::Gem::Version.new('1.2.3')
  end
end
