require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when validating User' do
    let(:user) { described_class.new }

    it 'checks for the presence of username' do
      user.valid?
      expect(user.errors[:username]).to include('can\'t be blank')
    end
  end
end
