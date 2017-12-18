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

end
