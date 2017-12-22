require_relative 'hex_mini_test'
require_relative '../../src/starter_service'
require 'json'

class TestBase < HexMiniTest

  def starter
    StarterService.new
  end

  def languages_choices(current_display_name)
    starter.languages_choices(current_display_name)
  end

  def exercises_choices
    starter.exercises_choices
  end

  def custom_choices(current_display_name)
    starter.custom_choices(current_display_name)
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
