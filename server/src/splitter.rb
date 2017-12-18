require_relative 'major_name'
require_relative 'minor_name'

class Splitter

  def initialize(display_names)
    @display_names = display_names
  end

  def major_names
    split { |display_name| major_name(display_name) }
  end

  def minor_names
    split { |display_name| minor_name(display_name) }
  end

  def minor_indexes
    major_names.map { |major_name| make_minor_indexes(major_name) }
  end

  private

  attr_reader :display_names

  include MajorName
  include MinorName

  def split
    display_names.map { |display_name| yield display_name }.sort.uniq
  end

  def make_minor_indexes(the_major_name)
    indexes = []
    display_names.each do |display_name|
      if major_name(display_name) == the_major_name
        indexes << minor_names.index(minor_name(display_name))
      end
    end
    indexes.sort
  end

end
