require File.expand_path 'lib/github/user.rb'

describe GitHub::User do

  def json_user
    open('test/data/user.json')
  end

  def json_users
    open('test/data/users.json')
  end

  def json_usernames
    open('test/data/usernames.json')
  end

  context 'get' do

    it 'the user given his username' do
      username = 'hugomaiavieira'
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}").
        and_return json_user
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
        and_return json_user
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

    it 'and returns an empty list for no existen username' do
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
      username = "hugomaiavieira"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/following?full=1").
        and_return json_users
      users = GitHub::User.followed_by username
      users_names = users.collect(&:name)
      users_names.should include('Hugo Lopes Tavares', 'Hugo Bonacci', 'Hugo Josefson')

      username = "algorich"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/following?full=1").
        and_return StringIO.new('{"users":[]}')
      users = GitHub::User.followed_by username
      users.should be_empty
    end

  end

  context 'usernames of followed by' do

    it 'returns the usernames of users followed by the given user' do
      username = "hugomaiavieira"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/following").
        and_return json_usernames
      usernames = GitHub::User.usernames_of_followed_by username
      usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

      username = "algorich"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/following").
        and_return StringIO.new('{"users":[]}')
      usernames = GitHub::User.usernames_of_followed_by username
      usernames.should be_empty
    end

  end

  context 'followers of' do

    it 'returns followers of the given user' do
      username = "hugomaiavieira"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/followers?full=1").
        and_return json_users
      users = GitHub::User.followers_of username
      users_names = users.collect(&:name)
      users_names.should include('Hugo Lopes Tavares', 'Hugo Bonacci', 'Hugo Josefson')

      username = "algorich"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/followers?full=1").
        and_return StringIO.new('{"users":[]}')
      users = GitHub::User.followers_of username
      users.should be_empty
    end

  end

  context 'usernames of followers of' do

    it 'returns the usernames of users that follows the given user' do
      username = "hugomaiavieira"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/followers").
        and_return json_usernames
      usernames = GitHub::User.usernames_of_followers_of username
      usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

      username = "algorich"
      GitHub::User.should_receive(:open).
        with("http://github.com/api/v2/json/user/show/#{username}/followers").
        and_return StringIO.new('{"users":[]}')
      usernames = GitHub::User.usernames_of_followers_of username
      usernames.should be_empty
    end

  end

end

