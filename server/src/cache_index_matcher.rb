
# When you are setting up a new cyber-dojo practice session
# cyber-dojo remembers the kata-id of the current practice session
# and the initially selected choices are the same as the
# current practice session (if they are still available).
# This is to help re-inforce the idea of repetition.
#
# For example, if the languages display_names are
#
#   [ "C#,Moq", "C#,NUnit", "Java,JUnit", "Java,Mockito" ]
#
# and the current practice session's display_name is "C#, NUnit",
# then the un-matched result of languages_choice() is:
#
#   {
#     "major_names"  : [ "C#", "Java" ],
#     "minor_names"  : [ "JUnit", "Mockito", "Moq", "NUnit" ],
#     "minor_indexes": [ [2,3], [1,0] ]
#   }
#
# CacheIndexMatcher.match_display_name() will alter this to:
#
#   {
#     "major_names"  : [ "C#", "Java" ],
#     "minor_names"  : [ "JUnit", "Mockito", "Moq", "NUnit" ],
#     "minor_indexes": [ [3,2], [1,0] ],
#     "major_index"  : 0
#   }
#
# Specifically:
#   major_name("C#,NUnit") == "C#"
#   minor_name("C#,NUnit") == "NUnit"
#
#   o) It will add a 'major_index' entry such that
#      major_names[major_index] == "C#"
#      If there is no matching major_name
#      (eg the current display_name is "Python, NUnit")
#      it will set it to a random index into major_names
#
#   o) It will ensure that
#      minor_names[minor_indexes[major_index][0]] == "NUnit"
#      If there is no matching minor_name
#      (eg the current display_name is "C#, py.test")
#      it will leave minor_indexes unchanged.

class CacheIndexMatcher

  def initialize(cache)
    @cache = cache
  end

  def match_display_name(current_display_name)
    current_display_name ||= ' , '
    cache[:major_index] = major_index(current_display_name)

    major_index = major_names.index(major_name(current_display_name))
    if major_index.nil?
      return
    end

    minor_index = minor_names.index(minor_name(current_display_name))
    if minor_index.nil?
      return
    end

    indexes = minor_indexes[major_index]
    indexes.delete(minor_index)
    indexes.unshift(minor_index)
  end

  # - - - - - - - - - - - - - - - - - - -

  def match_exercise_name(current_exercise_name)
    names = cache[:names]
    index = names.index(current_exercise_name)
    if index.nil?
      index = rand(0...names.size)
    end
    cache[:index] = index
  end

  private # = = = = = = = = = = = = = = = =

  attr_reader :cache

  def major_names
    cache[:major_names]
  end

  def minor_names
    cache[:minor_names]
  end

  def minor_indexes
    cache[:minor_indexes]
  end

  def major_index(current_display_name)
    current_major_name = major_name(current_display_name)
    index = major_names.index(current_major_name)
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
