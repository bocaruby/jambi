require File.dirname(__FILE__) + '/test_helper'

class JambiTest < Test::Unit::TestCase
  def setup
    @config = {
      'ruby_version'  => '1.8.7',
      'libdir'        => FIXTURES_PATH
    }
    @jambi = Jambi.new(@config, MOCK_GEMS_PATH)
  end

  def test_catalog_initialization
    assert_equal 1, @jambi.catalogs.size
    assert_equal [MOCK_GEMS_PATH], @jambi.catalogs.map {|c| c.dir}
  end

  def test_lib_dir_set_properly
    assert_equal FIXTURES_PATH, @jambi.lib_dir
  end

  def test_dir_set_properly
    assert_match /\.jambi$/, @jambi.dir
  end

  def test_version_set_properly
    assert_equal '1.8.7', @jambi.version
  end

  def test_gems_by_name_returns_proper_gems
    assert_equal 2, @jambi.gems_by_name('dummy').size
  end

  def test_gems_by_with_version_returns_proper_gems
    gems = @jambi.gems_by('dummy', '~> 2')
    assert_equal 1, gems.size
    assert gems.first.version == '2.3.0'
    assert_equal 'dummy-2.3.0', gems.first.full_name
  end

  def test_gems_can_be_loaded
    gem = @jambi.gems_by('dummy', '~> 1').first
    @jambi.load_gem(gem)
    assert @jambi.loaded_gems.has_key?(gem.name)
    assert_equal 1, @jambi.loaded_gems.values.size
    assert_match /dummy-1\.2\.3\/lib/, $:.join(':')
  end
end
