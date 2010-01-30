require File.dirname(__FILE__) + '/test_helper'

class CatalogTest < Test::Unit::TestCase
  def setup
    @catalog = Jambi::Gem::Catalog.new(MOCK_GEMS_PATH)
  end

  def test_finds_all_gems_in_directory
    assert_equal 2, @catalog.gems.size
  end

  def test_finds_all_gems_by_name
    assert_equal 2, @catalog.gems_by_name('dummy').size
  end

  def test_returns_an_empty_array_for_unknown_gem_names
    assert_equal [], @catalog.gems_by_name('idontexist')
  end

  def test_directory_must_exist
    assert_raise RuntimeError do
      Jambi::Gem::Catalog.new(nil)
    end
    assert_raise RuntimeError do
      Jambi::Gem::Catalog.new('')
    end
    assert_raise RuntimeError do
      Jambi::Gem::Catalog.new('/does/not/exist')
    end
  end
end
