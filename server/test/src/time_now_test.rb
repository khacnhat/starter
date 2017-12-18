require_relative '../../src/time_now'
require_relative 'test_base'

class TimeNowTest < TestBase

  def self.hex_prefix
    '4DB6F'
  end

  class FakeTime
    def year; 1966; end
    def month; 11; end
    def day; 23; end
    def hour; 8; end
    def min; 45; end
    def sec; 59; end
  end

  test '9F0',
  'time_now' do
    expected = [1966,11,23,8,45,59]
    assert_equal expected, time_now(FakeTime.new)
  end

  private

  include TimeNow

end
