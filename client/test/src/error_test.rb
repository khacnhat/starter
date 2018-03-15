require_relative 'test_base'

class ErrorTest < TestBase

  def self.hex_prefix
    'B7254'
  end

  # - - - - - - - - - - - - - - - - - - - - -

  test 'BD0',
  %w( bad arguments ) do
    error = assert_raises {
      starter.language_manifest('C#, NUnit', nil)
    }
    expected = 'StarterService:language_manifest:exercise_name:!string'
    assert_equal expected, error.message
  end

end
