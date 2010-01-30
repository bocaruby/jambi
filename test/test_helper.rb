require 'test/unit'
require 'jambi'

FIXTURES_PATH = File.join(File.dirname(__FILE__), 'fixtures')
MOCK_GEMS_PATH = File.join(FIXTURES_PATH, 'gems')


module RbConfig
  if defined? CONFIG
    send(:remove_const, :CONFIG)
  end

  CONFIG = {
    'ruby_version'  => '1.8.7',
    'libdir'        => FIXTURES_PATH
  }
end
