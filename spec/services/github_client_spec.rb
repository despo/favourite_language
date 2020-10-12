require 'rails_helper'
describe GithubClient do
  describe '#favourite_language' do
    it 'returns a user\'s favourite language' do
      expect(described_class.new('despo').favourite_language).to eq('Ruby')
    end
  end
end
