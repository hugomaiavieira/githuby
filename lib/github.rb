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
  PUBLIC_BASE_URL = 'https://api.github.com'

end

