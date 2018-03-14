require_relative 'test_base'

class LanguageManifestTest < TestBase

  def self.hex_prefix
    'D4735'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '266',
  %w( valid display_name,exercise_name with no optional properties ) do

    result = language_manifest('C#, NUnit', 'Fizz_Buzz')
    manifest = result['manifest']

    expected_keys = %w( display_name filename_extension image_name runner_choice visible_files )
    assert_equal expected_keys.sort, manifest.keys.sort

    assert_equal 'C#, NUnit', manifest['display_name']
    assert_equal '.cs', manifest['filename_extension']
    assert_equal 'cyberdojofoundation/csharp_nunit', manifest['image_name']
    assert_equal 'stateless', manifest['runner_choice']
    expected_filenames = %w( Hiker.cs HikerTest.cs cyber-dojo.sh output )
    assert_equal expected_filenames, manifest['visible_files'].keys.sort

    exercise = result['exercise']
    assert exercise.start_with? 'Write a program that prints the numbers from 1 to 100'
  end

end