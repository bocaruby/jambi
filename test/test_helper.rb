require 'test/unit'

class Jambi
  TESTING_JAMBI = true
end

require 'jambi'

FIXTURES_PATH = File.join(File.dirname(__FILE__), 'fixtures')
MOCK_GEMS_PATH = File.join(FIXTURES_PATH, 'gems')
