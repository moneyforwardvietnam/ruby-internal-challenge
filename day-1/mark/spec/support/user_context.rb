require "spec_helper"

RSpec.shared_context 'user' do
  let(:shared_user_name) { 'mark' }
  let(:shared_user_phone) { '081333555' }
  let(:shared_user) { User.new(name: shared_user_name, phone: shared_user_phone) }
end
