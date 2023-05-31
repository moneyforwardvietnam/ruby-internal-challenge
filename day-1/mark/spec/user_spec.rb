require "spec_helper"
require "user"

RSpec.describe User do

  describe 'create new user' do
    let(:name) { 'mark' }
    let(:phone) { '081333555' }

    context 'with name and phone provied' do
      before { @user = User.new(name: name, phone: phone) }

      it 'should have correct name' do
        expect(@user.name).to eq(name)
      end

      it 'should have correct phone' do
        expect(@user.phone).to eq(phone)
      end
    end
  end
end