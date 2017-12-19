require_relative 'test_base'

class ManifestTest < TestBase

  def self.hex_prefix
    '434DA'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '351',
  %w( hash with invalid argument becomes exception ) do
    assert_rack_call_raw('manifest',
      '{"old_name":42}',
      { exception:'old_name:invalid' }
    )
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '352', %w( old_name that maps simply to display_name ) do
    assert_new_style_manifest('C (gcc)-assert')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '353', %w( old_name that maps via rename to display_name ) do
    assert_new_style_manifest('C-assert')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '354', %w( old_name that is not found raises ) do
    manifest('')
    assert_exception('major_name:invalid')
    manifest('x')
    assert_exception('major_name:invalid')
    manifest('x-y')
    assert_exception('major_name:invalid')
    manifest('C (gcc)-xxx')
    assert_exception('minor_name:invalid')
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_new_style_manifest(old_name)
    result = manifest(old_name)
    assert result.key?('display_name')
    assert result.key?('image_name')
    refute result.key?('unit_test_framework')
  end

end