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

      it 'returns the users that the user is following' do
        user = GitHub::User.get 'hugomaiavieira'
        users = user.following
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Eduardo Hertz', 'Tarsis Azevedo')

        user = GitHub::User.get 'githubytest'
        user.following.should be_empty
      end

    end

    context 'following usernames' do

      it 'returns the usernames of users that the user is following' do
        user = GitHub::User.get 'hugomaiavieira'
        user.following_usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        user = GitHub::User.get 'githubytest'
        user.following_usernames.should be_empty
      end

    end

    context 'followers' do

      it 'returns the users that follows the user' do
        user = GitHub::User.get 'hugomaiavieira'
        users = user.followers
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Eduardo Hertz', 'Tarsis Azevedo')

        user = GitHub::User.get 'githubytest'
        user.followers.should be_empty
      end

    end

    context 'followers usernames' do

      it 'returns the usernames of users that follows the user' do
        user = GitHub::User.get 'hugomaiavieira'
        user.followers_usernames.should include('hugobr', 'eduardohertz', 'rodrigomanhaes')

        user = GitHub::User.get 'githubytest'
        user.followers_usernames.should be_empty
      end

    end

    context 'watched' do

      it 'returns the repositories that the user watch' do
        user = GitHub::User.get 'hugomaiavieira'
        repositories = user.watched
        repositories_names = repositories.collect(&:name)
        repositories_names.should include('should-dsl', 'afterFormat', 'rails_admin')

        user = GitHub::User.get 'githubytest'
        user.watched.should be_empty
      end

    end

  end

end

