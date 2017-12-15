
class Indexer

  def initialize(cache)
    @cache = cache
  end

  def align(recent_display_name)
    recent_display_name ||= ' , '
    cache['initial_index'] = major_index(recent_display_name)
    major_index = major_names.index(major_name(recent_display_name))
    return if major_index.nil?
    minor_index = minor_names.index(minor_name(recent_display_name))
    return if minor_index.nil?
    indexes = minor_indexes[major_index]
    indexes.delete(minor_index)
    indexes.unshift(minor_index)
  end

  private

  attr_reader :cache

  def major_names
    cache['major_names']
  end

  def minor_names
    cache['minor_names']
  end

  def minor_indexes
    cache['minor_indexes']
  end

  def major_index(recent_display_name)
    recent_major_name = major_name(recent_display_name)
    index = major_names.index(recent_major_name)
    if index.nil?
      return rand(0...major_names.size)
    end
    index
  end

  def major_name(display_name)
    display_name.split(',')[0].strip
  end

  def minor_name(display_name)
    display_name.split(',')[1].strip
  end

end
