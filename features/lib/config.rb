module Configuration
  ENVIRONMENT ||= ENV['ENV_CONFIG'] || 'pre-prod'

  def card_details_data
    path = File.expand_path('../../data/card_details.yml', __FILE__)
    load_file(path)
  end

  def load_file(path)
    Hashie::Mash.load(path)
  end

  def rated_people
    path = File.expand_path('../../../config.yml', __FILE__)
    load_file(path).send(ENVIRONMENT.to_s)
  end

end

World(Configuration)
