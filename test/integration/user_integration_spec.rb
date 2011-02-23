require File.expand_path 'lib/github/user.rb'

describe GitHub::User do

  context 'integration' do

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

      it 'and returns an empty list for no existen username' do
        users = GitHub::User.search_by_username 'someonethatnoexists'
        users.should be_empty
      end

    end

    context 'followed by' do

      it 'returns the users followed by the given user' do
        users = GitHub::User.followed_by 'hugomaiavieira'
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Eduardo Hertz', 'Tarsis Azevedo')

        users = GitHub::User.followed_by 'algorich'
        users.should be_empty
      end

    end

    context 'followers of' do

      it 'returns followers of the given user' do
        users = GitHub::User.followers_of 'hugomaiavieira'
        users_names = users.collect(&:name)
        users_names.should include('Hugo Lopes Tavares', 'Eduardo Hertz', 'Tarsis Azevedo')

        users = GitHub::User.followers_of 'algorich'
        users.should be_empty
      end

    end

  end
end

