require_relative 'test_base'

class MethodTest < TestBase

  def self.hex_prefix
    '444EB'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test '4A9',
  %w( method ) do
    assert_equal 42, method(6,7)
  end

end
