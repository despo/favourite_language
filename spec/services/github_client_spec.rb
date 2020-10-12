require 'rails_helper'
describe GithubClient do
  describe '#favourite_language' do
    it 'returns a user\'s favourite language' do
      expect(described_class.new('despo').favourite_language).to eq('Ruby')
    end

    it 'throws a UserNotFound exception when no such user' do
      expect { described_class.new('@despo').favourite_language }.to raise_error(GithubClient::UserNotFound)
    end

    it 'throws a NoUserRepositories exception when a user has no repositories' do
      expect { described_class.new('ariana-zz').favourite_language }.to raise_error(GithubClient::NoUserRepositories)
    end

    it 'throws a NoLanguagesUsed exception when a user has not used any programming languages' do
      expect { described_class.new('hkjj').favourite_language }.to raise_error(GithubClient::NoLanguagesUsed)
    end
  end
end
