
class Starter

  def method(a,b)
    a * b
  end

  def languages(major_name, minor_name)
    #returns a major-list (languages) and a minor-list (testFrameworks)
    #and initial indexes for both lists.
  end

  def exercises(exercise_name)
    #returns a list of exercises
    #and an initial index, given the 1 input name
  end

  def chose_language_exercise(major_name, minor_name, exercise_name)
    #creates a new kata in the storer
    #returns the new kata's hex-id
  end

  # - - - - - - - - - - - - - - - - -

  def custom(major_name, minor_name)
    #returns a major-list and a minor-list
    #and initial indexes for both lists
  end

  def chose_custom()
    #creates a new kata in the storer
    #returns the new kata's hex-id
  end

end

=begin
Notes
views/setup_default_start_point/show_languages.html.erb
        <%= render partial: 'shared/start_points_major_list' %>
views/shared/start_points_major_list.html.erb

  <% @start_points.major_names.each_with_index do |major_name, index| %>
    <div class="filename"
         id="major_<%= index %>"
         data-major="<%= major_name %>"
         data-index="<%= index %>"
         data-minor-index="<%= @start_points.minor_indexes[index][0] %>">
      <%= major_name %>
    </div>
  <% end %>

From controller
    languages_names = display_names_of(languages)
    kata = storer.kata_exists?(id) ? dojo.katas[id] : nil
    index = choose_language(languages_names, kata)
    @start_points = ::DisplayNamesSplitter.new(languages_names, index)

  def display_names_of(start_points)
    start_points.map(&:display_name).sort
  end

  def choose_language(languages, kata)
    chooser(languages, kata) { kata.display_name }
  end

  def chooser(choices, kata)
    choice = [*0...choices.length].sample
    unless kata.nil?
      index = choices.index(yield)
      choice = index unless index.nil?
    end
    choice
  end

See also app/lib/display_names_splitter.rb
for DisplayNamesSplitter

=end