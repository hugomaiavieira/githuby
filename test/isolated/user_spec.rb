require File.expand_path 'lib/github/user.rb'

describe GitHub::User do

  def json_user
    open('test/data/user.json')
  end

  def json_users
    open('test/data/users.json')
  end

  context 'get' do

    it 'the user given his username' do
      GitHub::User.should_receive(:open).
        with('http://github.com/api/v2/json/user/show/hugomaiavieira').
        and_return json_user
      user = GitHub::User.get 'hugomaiavieira'
      user.name.should == 'Hugo Maia Vieira'
    end

    it 'nil given an nonexistent username' do
      error_404 = OpenURI::HTTPError.new('404 Not Found', '')

      GitHub::User.should_receive(:open).
        with('http://github.com/api/v2/json/user/show/someonethatnoexists').
        and_raise error_404

      user = GitHub::User.get 'someonethatnoexists'
      user.should be_nil
    end

  end

  context 'search_by_email' do

    it 'and returns the user' do
      GitHub::User.should_receive(:open).
        with('http://github.com/api/v2/json/user/email/hugomaiavieira@gmail.com').
        and_return json_user
      user = GitHub::User.search_by_email 'hugomaiavieira@gmail.com'
      user.name.should == 'Hugo Maia Vieira'
    end

    it 'and returns nil for an nonexistent email' do
      error_404 = OpenURI::HTTPError.new('404 Not Found', '')

      GitHub::User.should_receive(:open).
        with('http://github.com/api/v2/json/user/email/nothing@email.com').
        and_raise error_404

      user = GitHub::User.search_by_email 'nothing@email.com'
      user.should be_nil
    end

  end

  context 'search_by_username' do

    it 'and returns a list of users' do
      GitHub::User.should_receive(:open).
        with('http://github.com/api/v2/json/user/search/hugo').
        and_return json_users
      users = GitHub::User.search_by_username 'hugo'
      users_names = users.collect(&:name)
      users_names.should include('Hugo Maia Vieira', 'Hugo Lopes Tavares')
    end

    it 'and returns an empty list for no existen username' do
      GitHub::User.should_receive(:open).
        with('http://github.com/api/v2/json/user/search/someonethatnoexists').
        and_return StringIO.new('{"users":[]}')
      users = GitHub::User.search_by_username 'someonethatnoexists'
      users.should be_empty
    end
  end

end

