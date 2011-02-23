require File.expand_path 'lib/github.rb'

module GitHub
  ##
  #
  # API for accessing and modifying user information.
  #
  # = Attributes
  #
  # - blog
  # - company
  # - created_at
  # - email
  # - followers_count
  # - following_count
  # - gravatar_id
  # - id
  # - location
  # - login
  # - name
  # - permission
  # - public_gist_count
  # - public_repo_count
  # - type
  #
  # *Note:* {GitHub::User} intances generated by {followers}, {following},
  # {#followers} and {#following} just have the attributes _blog_, _email_,
  # _gravatar_id_, _location_, _login_, _name_ and _type_
  #
  class User < Hashie::Mash

    ##
    #
    # Returns a {GitHub::User} object with all extended information on users by
    # their username.
    #
    def self.get(username)
      url = [PUBLIC_BASE_URL, 'user/show', username].join('/')
      self.new JSON.parse(open(url).read)['user']
      rescue OpenURI::HTTPError
        return nil
    end

    ##
    #
    # Search users by email address. This only matches against the email address
    # the user has listed on their public profile, and is opt-in for everyone.
    #
    def self.search_by_email(email)
      url = [PUBLIC_BASE_URL, 'user/email', email].join('/')
      self.new JSON.parse(open(url).read)['user']
      rescue OpenURI::HTTPError
        return nil
    end

    ##
    #
    # Search users by the github username returning a {GitHub::User} objects
    # list.
    #
    def self.search_by_username(username)
      url = [PUBLIC_BASE_URL, 'user/search', username].join('/')
      users = JSON.parse(open(url).read)['users']
      users.collect { |user| self.new user }
    end

    ##
    #
    # Returns a {GitHub::User} objects list with the users that the user is
    # following.
    #
    def self.following(username)
      attributes = '?full=1'
      url = [PUBLIC_BASE_URL, 'user/show', username, 'following'].join('/')
      p url
      users = JSON.parse(open(url+attributes).read)['users']
      users.collect { |user| self.new user }
    end

    ##
    #
    # Returns a list with the usernames of users that the user is following.
    #
    def self.following_usernames(username)
      url = [PUBLIC_BASE_URL, 'user/show', username, 'following'].join('/')
      JSON.parse(open(url).read)['users']
    end

    ##
    #
    # Returns a {GitHub::User} objects list with the users that follows the user.
    #
    def self.followers(username)
      attributes = '?full=1'
      url = [PUBLIC_BASE_URL, 'user/show', username, 'followers'].join('/')
      users = JSON.parse(open(url+attributes).read)['users']
      users.collect { |user| self.new user }
    end

    ##
    #
    # Returns a list with the usernames of users that follows the user.
    #
    def self.followers_usernames(username)
      url = [PUBLIC_BASE_URL, 'user/show', username, 'followers'].join('/')
      JSON.parse(open(url).read)['users']
    end

    ##
    #
    # Returns a {GitHub::Repository} objects list with the repositories that the
    # user watch.
    #
    def self.watched(username)
      url = [PUBLIC_BASE_URL, 'repos/watched', username].join('/')
      repositories = JSON.parse(open(url).read)['repositories']
      repositories.collect { |repository| GitHub::Repository.new repository }
    end

    ##
    #
    # Returns a {GitHub::User} objects list with the users that the user is
    # following.
    #
    def following
      attributes = '?full=1'
      url = [PUBLIC_BASE_URL, 'user/show', self.login, 'following'].join('/')
      users = JSON.parse(open(url+attributes).read)['users']
      users.collect { |user| self.new user }
    end

    ##
    #
    # Returns a {GitHub::User} objects list with the users that follows the user.
    #
    def followers
      attributes = '?full=1'
      url = [PUBLIC_BASE_URL, 'user/show', self.login, 'followers'].join('/')
      users = JSON.parse(open(url+attributes).read)['users']
      users.collect { |user| self.new user }
    end

    ##
    #
    # Returns a {GitHub::Repository} objects list with the repositories that the
    # user watch.
    #
    def watched
      url = [PUBLIC_BASE_URL, 'repos/watched', self.login].join('/')
      repositories = JSON.parse(open(url).read)['repositories']
      repositories.collect { |repository| GitHub::Repository.new repository }
    end

  end
end

