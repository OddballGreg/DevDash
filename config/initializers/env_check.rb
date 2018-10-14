%w[REDIS_URL 
  TRELLO_API_KEY 
  TRELLO_API_TOKEN].each do |env_key|
    throw "#{env_key} not present if in env" unless ENV[env_key].present?
  end 