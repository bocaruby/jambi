require File.dirname(__FILE__) + '/test_helper'

class GemTest < Test::Unit::TestCase
  def setup
    @catalog = Jambi::Gem::Catalog.new(MOCK_GEMS_PATH)
    @gem = Jambi::Gem.new('example_gem-1.2.3', @catalog)
  end

  def test_responds_to_name
    assert_equal 'example_gem', @gem.name
  end

  def test_had_a_lib_dir
    assert_equal 'example_gem-1.2.3/lib', @gem.lib_dir
  end

  def test_equality
    assert @gem == Jambi::Gem.new('example_gem-1.2.3', @catalog)
  end

  def test_version_greater_than
    assert @gem > Jambi::Gem.new('example_gem-1.0.0', @catalog)
  end

  def test_version_less_than
    assert @gem < Jambi::Gem.new('example_gem-1.5.0', @catalog)
  end

  def test_name_greater_than
    assert @gem > Jambi::Gem.new('another_gem-1.2.3', @catalog)
  end

  def test_name_less_than
    assert @gem < Jambi::Gem.new('zebra-0.0.0', @catalog)
  end
end

