
class Splitter

  def initialize(display_names) #, initial_index)
    @display_names = display_names
    #@initial_index = initial_index
  end

  def major_names
    split(0)
  end

  def minor_names
    split(1)
  end

  def minor_indexes
    major_names.map { |major_name| make_minor_indexes(major_name) }
  end

  def initial_index
    name = @display_names[@initial_index].split(',')[0].strip
    major_names.index(name)
  end

private

  def split(n)
    @display_names.map { |display_name| display_name.split(',')[n].strip }.sort.uniq
  end

  def make_minor_indexes(major_name)
    indexes = []
    @display_names.each do |display_name|
      if display_name.start_with?(major_name + ',')
        minor_name = display_name.split(',')[1].strip
        indexes << minor_names.index(minor_name)
      end
    end

=begin
    if major_name == major_names[initial_index]
      minor_name = @display_names[@initial_index].split(',')[1].strip
      minor_index = minor_names.index(minor_name)
      indexes.delete(minor_index)
      indexes.unshift(minor_index)
    end
=end
    indexes
  end

end
