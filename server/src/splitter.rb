
class Splitter

  def initialize(display_names, recent_display_name)
    @display_names = display_names
    @recent_display_name = recent_display_name || ' , '
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

  def initial_index
    recent_major_name = major_name(recent_display_name)
    index = major_names.index(recent_major_name)
    if index.nil?
      return rand(0...major_names.size)
    end
    index
  end

  private

  attr_reader :display_names, :recent_display_name

  def split
    display_names.map { |display_name| yield display_name }.sort.uniq
  end

  def major_name(display_name)
    display_name.split(',')[0].strip
  end

  def minor_name(display_name)
    display_name.split(',')[1].strip
  end

  def make_minor_indexes(the_major_name)
    indexes = []
    display_names.each do |display_name|
      if major_name(display_name) == the_major_name
        indexes << minor_names.index(minor_name(display_name))
      end
    end
    if the_major_name == major_name(recent_display_name)
      minor_index = minor_names.index(minor_name(recent_display_name))
      unless minor_index.nil?
        indexes.delete(minor_index)
        indexes.unshift(minor_index)
      end
    end
    indexes
  end

end
