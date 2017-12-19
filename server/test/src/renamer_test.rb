require_relative 'test_base'

class RenamerTest < TestBase

  def self.hex_prefix
    '1BF95'
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C3', %w( when found return new-name ) do
    assert_renamed ['C'], ['C (gcc)','assert']
    assert_renamed ['Perl','TestSimple'], ['Perl','Test::Simple']
    assert_renamed ['C'], ['C (gcc)','assert']
  end

  # - - - - - - - - - - - - - - - - - - - -

  test '9C4', %w( when not-found return arg ) do
    assert_not_renamed ['x']
    assert_not_renamed ['C','x']
    assert_not_renamed ['x','TestSimple']
    assert_not_renamed ['x','Test::Simple']
  end

  # - - - - - - - - - - - - - - - - - - - -

  def assert_renamed(from, to)
    renamer = Renamer.new
    assert_equal to, renamer.renamed(from)
  end

  def assert_not_renamed(arg)
    renamer = Renamer.new
    assert_equal arg, renamer.renamed(arg)
  end

end