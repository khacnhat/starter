require_relative 'test_base'

class LanguageManifestTest < TestBase

  def self.hex_prefix
    '3D915'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7A',
  %w( missing argument becomes exception ) do
    assert_rack_call_raw('language_manifest',
      '{}',
      { exception:'display_name:missing' }
    )
    assert_rack_call_raw('language_manifest',
      '{"display_name":42}',
      { exception:'exercise_name:missing' }
    )
    assert_rack_call_raw('language_manifest',
      '{"exercise_name":42}',
      { exception:'display_name:missing' }
    )
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7B',
  %w( non-string argument becomes exception ) do
    language_manifest(42, 'Fizz_Buzz')
    assert_exception('display_name:!string')

    language_manifest('xxx', 42)
    assert_exception('exercise_name:!string')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7C', %w( unknown display_name becomes exception ) do
    language_manifest('xxx, NUnit', 'Fizz_Buzz')
    assert_exception('display_name:xxx, NUnit:unknown')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7D', %w( unknown exercise_name becomes exception ) do
    language_manifest('C#, NUnit', 'xxx')
    assert_exception('exercise_name:xxx:unknown')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7E', %w( valid with no optional properties ) do
    result = language_manifest('C#, NUnit', 'Fizz_Buzz')

    manifest = result['manifest']
    expected_keys = %w(
      display_name filename_extension image_name runner_choice visible_files
    )
    assert_equal expected_keys.sort, manifest.keys.sort

    assert_equal 'C#, NUnit', manifest['display_name']
    assert_equal '.cs', manifest['filename_extension']
    assert_equal 'cyberdojofoundation/csharp_nunit', manifest['image_name']
    assert_equal 'stateless', manifest['runner_choice']
    expected_filenames = %w( Hiker.cs HikerTest.cs cyber-dojo.sh output )
    assert_equal expected_filenames, manifest['visible_files'].keys.sort

    instructions = result['exercise']
    assert instructions.start_with?('Write a program that prints')
  end

  # - - - - - - - - - - - - - - - - - - - -

  test 'D7F', %w( valid with some optional properties ) do
    result = language_manifest('Python, unittest', 'Fizz_Buzz')

    manifest = result['manifest']
    expected_keys = %w(
      display_name image_name runner_choice visible_files
      filename_extension highlight_filenames max_seconds progress_regexs tab_size
    )
    assert_equal expected_keys.sort, manifest.keys.sort

    assert_equal 'Python, unittest', manifest['display_name']
    assert_equal 'cyberdojofoundation/python_unittest', manifest['image_name']
    assert_equal 'stateless', manifest['runner_choice']
    expected_filenames = %w( cyber-dojo.sh hiker.py output test_hiker.py )
    assert_equal expected_filenames, manifest['visible_files'].keys.sort

    assert_equal [ 'test_hiker.py' ], manifest['highlight_filenames']
    assert_equal '.py', manifest['filename_extension']
    assert_equal 11, manifest['max_seconds']
    assert_equal [ 'FAILED \\(failures=\\d+\\)', 'OK' ], manifest['progress_regexs']
    assert_equal 3, manifest['tab_size']

    instructions = result['exercise']
    assert instructions.start_with?('Write a program that prints')
  end

end