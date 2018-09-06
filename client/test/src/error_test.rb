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
    assert_equal 'ServiceError', error.class.name
    assert_equal 'StarterService', error.service_name
    assert_equal 'language_manifest', error.method_name
    assert_equal '"exercise_name:!string"', error.message
  end

end
