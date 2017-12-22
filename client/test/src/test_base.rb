require_relative 'hex_mini_test'
require_relative '../../src/starter_service'
require 'json'

class TestBase < HexMiniTest

  def starter
    StarterService.new
  end

  def custom_choices
    starter.custom_choices
  end

  def languages_choices
    starter.languages_choices
  end

  def exercises_choices
    starter.exercises_choices
  end

  # - - - - - - - - - - - - - - - - - -

  def language_manifest(major_name, minor_name, exercise_name)
    starter.language_manifest(major_name, minor_name, exercise_name)
  end

  def custom_manifest(major_name, minor_name)
    starter.custom_manifest(major_name, minor_name)
  end

  def manifest(old_name)
    starter.manifest(old_name)
  end

end
