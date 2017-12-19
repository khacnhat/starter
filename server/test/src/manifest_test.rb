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
    assert_manifest('C (gcc)-assert')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '353', %w( old_name that maps via rename to display_name ) do
    assert_manifest('C-assert')
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

  def assert_manifest(old_name)
    result = manifest(old_name)
    required_keys = %w(
      id
      created
      display_name
      image_name
      runner_choice
      language
      visible_files
      max_seconds
      tab_size
      filename_extension
      progress_regexs
      highlight_filenames
      lowlight_filenames
    )
    required_keys.each { |name| assert result.key?(name), name }
    refute result.key?('unit_test_framework')
    refute result.key?('exercise')
  end

end