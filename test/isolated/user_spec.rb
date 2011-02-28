require File.expand_path 'test/support/spec_helper.rb'

describe GitHub::User do

  context 'class' do

    context 'get' do

      it 'the user given his username' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_hugomaiavieira
        user = GitHub::User.get username
        user.name.should == 'Hugo Maia Vieira'
      end

      it 'nil given an nonexistent username' do
        username = 'someonethatnoexists'
        error_404 = OpenURI::HTTPError.new('404 Not Found', '')
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_raise error_404
        user = GitHub::User.get username
        user.should be_nil
      end

    end

    context 'search_by_email' do

      it 'and returns the user' do
        email = 'hugomaiavieira@gmail.com'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/email/#{email}").
          and_return json_hugomaiavieira
        user = GitHub::User.search_by_email email
        user.name.should == 'Hugo Maia Vieira'
      end

      it 'and returns nil for an nonexistent email' do
        email = 'nothing@email.com'
        error_404 = OpenURI::HTTPError.new('404 Not Found', '')
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/email/#{email}").
          and_raise error_404
        user = GitHub::User.search_by_email email
        user.should be_nil
      end

    end

    context 'search_by_username' do

      it 'and returns a list of users' do
        username = 'hugo'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/search/#{username}").
          and_return json_users
        users = GitHub::User.search_by_username username
        users_names = users.collect(&:name)
        users_names.should include('Hugo Maia Vieira', 'Hugo Lopes Tavares')
      end

      it 'and returns an empty list for nonexistent username' do
        username = 'someonethatnoexists'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/search/#{username}").
          and_return StringIO.new('{"users":[]}')
        users = GitHub::User.search_by_username username
        users.should be_empty
      end

    end

    context 'followed by' do

      it 'returns the users followed by the given user' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following?full=1").
          and_return json_users
        users = GitHub::User.followed_by username
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Hugo Bonacci', 'Hugo Josefson')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following?full=1").
          and_return StringIO.new('{"users":[]}')
        users = GitHub::User.followed_by username
        users.should be_empty
      end

      it 'nil given an nonexistent username' do
        username = 'someonethatnoexists'
        error_404 = OpenURI::HTTPError.new('404 Not Found', '')
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following?full=1").
          and_raise error_404
        user = GitHub::User.followed_by username
        user.should be_nil
      end

    end

    context 'usernames of followed by' do

      it 'returns the usernames of users followed by the given user' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following").
          and_return json_usernames
        usernames = GitHub::User.usernames_of_followed_by username
        usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following").
          and_return StringIO.new('{"users":[]}')
        usernames = GitHub::User.usernames_of_followed_by username
        usernames.should be_empty
      end

      it 'nil given an nonexistent username' do
        username = 'someonethatnoexists'
        error_404 = OpenURI::HTTPError.new('404 Not Found', '')
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following").
          and_raise error_404
        user = GitHub::User.usernames_of_followed_by username
        user.should be_nil
      end

    end

    context 'followers of' do

      it 'returns followers of the given user' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers?full=1").
          and_return json_users
        users = GitHub::User.followers_of username
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Hugo Bonacci', 'Hugo Josefson')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers?full=1").
          and_return StringIO.new('{"users":[]}')
        users = GitHub::User.followers_of username
        users.should be_empty
      end

      it 'nil given an nonexistent username' do
        username = 'someonethatnoexists'
        error_404 = OpenURI::HTTPError.new('404 Not Found', '')
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers?full=1").
          and_raise error_404
        user = GitHub::User.followers_of username
        user.should be_nil
      end

    end

    context 'usernames of followers of' do

      it 'returns the usernames of users that follows the given user' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers").
          and_return json_usernames
        usernames = GitHub::User.usernames_of_followers_of username
        usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers").
          and_return StringIO.new('{"users":[]}')
        usernames = GitHub::User.usernames_of_followers_of username
        usernames.should be_empty
      end

      it 'nil given an nonexistent username' do
        username = 'someonethatnoexists'
        error_404 = OpenURI::HTTPError.new('404 Not Found', '')
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers").
          and_raise error_404
        user = GitHub::User.usernames_of_followers_of username
        user.should be_nil
      end

    end

    context 'watched by' do

      it 'returns the repositories watched by the given user' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/repos/watched/#{username}").
          and_return json_repositories
        repositories = GitHub::User.watched_by username
        repositories_names = repositories.collect(&:name)
        repositories_names.should include('should-dsl', 'afterFormat', 'rails_admin')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/repos/watched/#{username}").
          and_return StringIO.new('{"repositories":[]}')
        repositories = GitHub::User.watched_by username
        repositories.should be_empty
      end

      it 'nil given an nonexistent username' do
        username = 'someonethatnoexists'
        error_404 = OpenURI::HTTPError.new('404 Not Found', '')
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/repos/watched/#{username}").
          and_raise error_404
        user = GitHub::User.watched_by username
        user.should be_nil
      end

    end

  end

  context 'instance' do

    context 'following' do

      it 'returns the users that the user is following' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_hugomaiavieira
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following?full=1").
          and_return json_users
        users = user.following
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Hugo Bonacci', 'Hugo Josefson')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_githubtest
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following?full=1").
          and_return StringIO.new('{"users":[]}')
        user.following.should be_empty
      end

    end

    context 'following usernames' do

      it 'returns the usernames of users that the user is following' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_hugomaiavieira
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following").
          and_return json_usernames
        user.following_usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_githubtest
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/following").
          and_return StringIO.new('{"users":[]}')
        user.following_usernames.should be_empty
      end

    end

    context 'followers' do

      it 'returns the users that follows the user' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_hugomaiavieira
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers?full=1").
          and_return json_users
        users = user.followers
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Hugo Bonacci', 'Hugo Josefson')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_githubtest
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers?full=1").
          and_return StringIO.new('{"users":[]}')
        user.followers.should be_empty
      end

    end

    context 'followers usernames' do

      it 'returns the usernames of users that follows the user' do
        username = 'hugomaiavieira'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_hugomaiavieira
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers").
          and_return json_usernames
        user.followers_usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        username = 'githubytest'
        GitHub::User.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}").
          and_return json_githubtest
        user = GitHub::User.get username
        user.should_receive(:open).
          with("http://github.com/api/v2/json/user/show/#{username}/followers").
          and_return StringIO.new('{"users":[]}')
        user.followers_usernames.should be_empty
      end

    end

  end

end

