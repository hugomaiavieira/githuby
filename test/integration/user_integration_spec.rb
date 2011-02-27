require File.expand_path 'test/support/spec_helper.rb'

describe GitHub::User do

  context 'class' do

    context 'get' do

      it 'the user given his username' do
        user = GitHub::User.get 'hugomaiavieira'
        user.name.should == 'Hugo Maia Vieira'
      end

      it 'nil given an nonexistent username' do
        user = GitHub::User.get 'someonethatnoexists'
        user.should be_nil
      end

    end

    context 'search_by_email' do

      it 'and returns the user' do
        user = GitHub::User.search_by_email 'hugomaiavieira@gmail.com'
        user.name.should == 'Hugo Maia Vieira'
      end

      it 'and returns nil for an nonexistent email' do
        user = GitHub::User.search_by_email 'nothing@email.com'
        user.should be_nil
      end

    end

    context 'search_by_username' do

      it 'and returns a list of users' do
        users = GitHub::User.search_by_username 'hugo'
        users_names = users.collect(&:name)
        users_names.should include('Hugo Maia Vieira', 'Hugo Lopes Tavares')
      end

      it 'and returns an empty list for nonexistent username' do
        users = GitHub::User.search_by_username 'someonethatnoexists'
        users.should be_empty
      end

    end

    context 'followed by' do

      it 'returns the users followed by the given user' do
        users = GitHub::User.followed_by 'hugomaiavieira'
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Eduardo Hertz', 'Tarsis Azevedo')

        users = GitHub::User.followed_by 'githubytest'
        users.should be_empty
      end

      it 'nil given an nonexistent username' do
        user = GitHub::User.followed_by 'someonethatnoexists'
        user.should be_nil
      end

    end

    context 'usernames of followed by' do

      it 'returns the usernames of users followed by the given user' do
        usernames = GitHub::User.usernames_of_followed_by 'hugomaiavieira'
        usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        usernames = GitHub::User.usernames_of_followed_by 'githubytest'
        usernames.should be_empty
      end

      it 'nil given an nonexistent username' do
        user = GitHub::User.usernames_of_followed_by 'someonethatnoexists'
        user.should be_nil
      end

    end

    context 'followers of' do

      it 'returns followers of the given user' do
        users = GitHub::User.followers_of 'hugomaiavieira'
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Eduardo Hertz', 'Tarsis Azevedo')

        users = GitHub::User.followers_of 'githubytest'
        users.should be_empty
      end

      it 'nil given an nonexistent username' do
        user = GitHub::User.followers_of 'someonethatnoexists'
        user.should be_nil
      end

    end

    context 'usernames of followers of' do

      it 'returns the usernames of users that follows the given user' do
        usernames = GitHub::User.usernames_of_followers_of 'hugomaiavieira'
        usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        usernames = GitHub::User.usernames_of_followers_of 'githubytest'
        usernames.should be_empty
      end

      it 'nil given an nonexistent username' do
        user = GitHub::User.usernames_of_followers_of 'someonethatnoexists'
        user.should be_nil
      end

    end

    context 'watched by' do

      it 'returns the repositories watched by the given user' do
        repositories = GitHub::User.watched_by 'hugomaiavieira'
        repositories_names = repositories.collect(&:name)
        repositories_names.should include('should-dsl', 'afterFormat', 'rails_admin')

        repositories = GitHub::User.watched_by 'githubytest'
        repositories.should be_empty
      end

      it 'nil given an nonexistent username' do
        user = GitHub::User.watched_by 'someonethatnoexists'
        user.should be_nil
      end

    end

  end

  context 'instance' do

    context 'following' do

      it 'returns the users followed by the given user' do
        username = 'hugomaiavieira'
        user = GitHub::User.get(username)
        users = user.following
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Eduardo Hertz', 'Tarsis Azevedo')

        username = 'githubytest'
        user = GitHub::User.get(username)
        users = GitHub::User.followed_by username
        users.should be_empty
      end

    end

  end

end

