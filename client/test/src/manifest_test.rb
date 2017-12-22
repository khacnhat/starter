require_relative 'test_base'

class ManifestTest < TestBase

  def self.hex_prefix
    'C592E'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '7AA',
  %w( invalid old_name becomes exception ) do
    assert_manifest_raises(42, 'old_name')
    assert_manifest_raises('', 'major_name')
    assert_manifest_raises('x', 'major_name')
    assert_manifest_raises('x-y', 'major_name')
    assert_manifest_raises('C (gcc)-xxx', 'minor_name')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '7AB', %w( old_name that maps simply ) do
    assert_manifest('C (gcc)-assert')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '7AC', %w( old_name that maps via rename ) do
    assert_manifest('C-assert')
  end

  private

  def assert_manifest_raises(old_name, name)
    error = assert_raises(RuntimeError) { manifest(old_name) }
    assert_equal "StarterService:manifest:#{name}:invalid", error.message
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
      visible_files
      max_seconds
      tab_size
      filename_extension
      progress_regexs
      highlight_filenames
      lowlight_filenames
    )
    required_keys.each { |name| assert result.key?(name), name }
    # unit_test_framework is a property in old-style KATA manifests.
    refute result.key?('unit_test_framework')
    # exercise is a property in KATA manifests.
    refute result.key?('exercise')
  end

end