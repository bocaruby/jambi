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
    assert @version > '1.0.0'
    assert @version.send('>', '1.0.0')
  end

  def test_handles_less_than_comparison
    assert @version < '1.5.0'
    assert @version.send('<', '1.5.0')
    assert_equal false, @version < '1.2.0'
  end

  def test_handles_equals_to_comparison
    assert @version == '1.2.3'
    assert @version.send('==', '1.2.3')
    assert @version.send('=', '1.2.3')
    assert_equal false, @version == '1.0.0'
  end

  def test_handles_major_match_comparison
    assert @version.send('~>', '1.0.0')
    assert_equal false, @version.send('~>', '2.0.1')
  end

  def test_handles_greater_than_or_equal_to
    assert @version >= '1.2.3'
    assert @version.send('>=', '1.2.0')
    assert_equal false, @version >= '1.2.5'
  end

  def test_handles_not_equal_to
    assert @version != '1.2.1'
    assert @version.send('!=', '1.2.1')
    assert_equal false, @version != '1.2.3'
  end

  def test_handles_version_0
    assert @version > '0'
  end

  def test_to_s
    assert @version.to_s == '1.2.3'
    assert Jambi::Gem::Version.new('3').to_s == '3'
    assert Jambi::Gem::Version.new('3.2').to_s == '3.2'
    assert Jambi::Gem::Version.new('3.2.4').to_s == '3.2.4'
    assert Jambi::Gem::Version.new('3.2.4.5').to_s == '3.2.4.5'
  end
end
