require_relative 'hex_mini_test'
require_relative '../../src/starter_service'
require 'json'

class TestBase < HexMiniTest

  def starter
    StarterService.new
  end

  def method(a, b)
    starter.method(a, b)
  end

end
