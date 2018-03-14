require_relative 'test_base'

class CustomManifestTest < TestBase

  def self.hex_prefix
    'F491E'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C0',
  %w( missing display_name becomes exception ) do
    assert_rack_call_raw('custom_manifest',
      '{}',
      { exception:'display_name:missing' }
    )
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C1',
  %w( non-string display_name becomes exception ) do
    custom_manifest(42)
    assert_exception('display_name:!string')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C2',
  %w( unknown display_name becomes exception ) do
    custom_manifest('xxx, C# NUnit')
    assert_exception('display_name:xxx, C# NUnit:unknown')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C3',
  %w( valid display_name ) do
    manifest = custom_manifest('Yahtzee refactoring, C# NUnit')

    expected_keys = %w(
      display_name image_name runner_choice visible_files
      filename_extension
    )
    assert_equal expected_keys.sort, manifest.keys.sort

    assert_equal 'Yahtzee refactoring, C# NUnit', manifest['display_name']
    assert_equal '.cs', manifest['filename_extension']
    assert_equal 'cyberdojofoundation/csharp_nunit', manifest['image_name']
    assert_equal 'stateless', manifest['runner_choice']
    expected_filenames = %w( Yahtzee.cs YahtzeeTest.cs cyber-dojo.sh instructions output )
    assert_equal expected_filenames, manifest['visible_files'].keys.sort
  end

end