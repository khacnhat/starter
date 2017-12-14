require_relative 'test_base'

class MethodTest < TestBase

  def self.hex_prefix
    '9F544'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '0F3',
  'method' do
    assert_equal 42, method(6, 7)
  end

end
