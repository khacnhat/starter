require_relative 'test_base'

class OldManifestTest < TestBase

  def self.hex_prefix
    'C592E'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '7AA',
  %w( invalid old_name becomes exception ) do
    assert_old_manifest_raises(42, 'old_name', '!string')
    assert_old_manifest_raises('', 'old_name', 'unknown')
    assert_old_manifest_raises('x', 'old_name', 'unknown')
    assert_old_manifest_raises('x-y', 'old_name', 'unknown')
    assert_old_manifest_raises('C (gcc)-xxx', 'old_name', 'unknown')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '7AB', %w( old_name that maps simply ) do
    assert_c_assert_manifest('C (gcc)-assert')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '7AC', %w( old_name that maps via rename ) do
    assert_c_assert_manifest('C-assert')
  end

  private

  def assert_old_manifest_raises(old_name, name, msg)
    error = assert_raises(RuntimeError) { old_manifest(old_name) }
    assert_equal "StarterService:old_manifest:#{name}:#{msg}", error.message
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

end