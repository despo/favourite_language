require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when validating User' do
    let(:user) { described_class.new }

    it 'checks for the presence of username' do
      user.valid?
      expect(user.errors[:username]).to include('can\'t be blank')
    end
  end

  describe '#favourite_language' do
    let(:user) { described_class.new(username: 'despo') }

    it 'retrieves the favourite language using the GithubClient service' do
      github_client = instance_double('GithubClient', favourite_language: 'Ruby')
      allow(GithubClient).to receive(:new).with('despo').and_return(github_client)

      expect(user.favourite_language).to eq('Ruby')
    end
  end
end
