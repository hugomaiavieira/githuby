require 'github'

def json_user
  open(File.dirname(__FILE__) + '/data/user.json')
end

def json_users
  open(File.dirname(__FILE__) + '/data/users.json')
end

def json_usernames
  open(File.dirname(__FILE__) + '/data/usernames.json')
end

def json_repositories
  open(File.dirname(__FILE__) + '/data/repositories.json')
end

