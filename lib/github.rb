require 'open-uri'
require 'json'
require 'hashie'

%w(repository user).each {|req| require File.dirname(__FILE__) + "/github/#{req}"}

##
#
# API for accessing and modifying GitHub information.
#
module GitHub

  ##
  #
  # For public access, via http
  #
  PUBLIC_BASE_URL = 'http://github.com/api/v2/json'

  ##
  #
  # For authenticated access, via https
  #
  SECURE_BASE_URL = 'https://github.com/api/v2/json'

end

