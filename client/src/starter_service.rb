require_relative 'http_json_service'

class StarterService

  def languages_choices(current_display_name)
    get([current_display_name], __method__)
  end

  def exercises_choices(current_exercise_name)
    get([current_exercise_name], __method__)
  end

  private

  include HttpJsonService

  def hostname
    ENV['CYBER_DOJO_STARTER_SERVER_NAME']
  end

  def port
    ENV['CYBER_DOJO_STARTER_SERVER_PORT']
  end

end
