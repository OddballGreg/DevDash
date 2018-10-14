%w[REDIS_URL 
  TRELLO_API_KEY
  DEVDASH_DATABASE_PASSWORD].each do |env_key|
    throw "#{env_key} not present if in env" unless ENV[env_key].present?
  end 