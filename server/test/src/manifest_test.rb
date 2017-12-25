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

  test '352', %w( old_name that is not found raises ) do
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

  test '353', %w( old_name that maps simply ) do
    assert_c_assert_manifest('C (gcc)-assert')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '354', %w( old_name that maps via rename ) do
    assert_c_assert_manifest('C-assert')
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_c_assert_manifest(old_name)
    manifest = old_manifest(old_name)

    expected_keys = %w(
      display_name image_name runner_choice visible_files
      filename_extension
    )
    assert_equal expected_keys.sort, manifest.keys.sort

    assert_equal 'C (gcc), assert', manifest['display_name']
    assert_equal 'cyberdojofoundation/gcc_assert', manifest['image_name']
    assert_equal '.c', manifest['filename_extension']
    assert_equal 'stateful', manifest['runner_choice']
    expected_filenames = %w( cyber-dojo.sh hiker.c hiker.h hiker.tests.c makefile output )
    assert_equal expected_filenames, manifest['visible_files'].keys.sort
  end

  def old_manifest(old_name)
    manifest(old_name)
  end

end