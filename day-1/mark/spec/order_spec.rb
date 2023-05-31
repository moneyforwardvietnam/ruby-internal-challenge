require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
 
  include_context 'user'
  include_context 'order_items'

  describe 'create a new order' do
    context 'with user and items' do
      let(:order) { Order.new(user: shared_user, items: shared_order_items) }

      before { order }

      it 'should have correct user' do
        expect(order.user).to eq(shared_user)
        expect(order.user.name).to eq(shared_user.name)
        expect(order.user.phone).to eq(shared_user.phone)
      end

      it 'should have correct number of order items' do
        expect(order.items.count).to eq(shared_order_items.count)
      end

      it 'should have correct order items' do
        expect(order.items).to include(shared_order_items.first)
        expect(order.items).to include(shared_order_items.last)
      end

      it 'should have initial price equals 0.0' do
        expect(order.price).to eq(0.0)
      end

      it 'should have initial discount equals 0.0' do
        expect(order.discount).to eq(0.0)
      end

      it 'should have initial final price equals 0.0' do
        expect(order.final_price).to eq(0.0)
      end
    end

    context 'without user and items' do
      let(:order) { Order.new(user: nil, items: []) }

      before { order }

      it 'should not have any user' do
        expect(order.user).to be_nil
      end

      it 'should not have any items' do
        expect(order.items).to be_empty
      end

      it 'should have initial price equals 0.0' do
        expect(order.price).to eq(0.0)
      end

      it 'should have initial discount equals 0.0' do
        expect(order.discount).to eq(0.0)
      end

      it 'should have initial final price equals 0.0' do
        expect(order.final_price).to eq(0.0)
      end
    end
  end

  describe "#add_item" do
    let(:order) { Order.new(user: shared_user, items: []) }

    before { order.add_item(shared_order_items.first) }
   
    it 'should add correct item into the order' do
      expect(order.items).to include(shared_order_items.first)
    end

    it 'should have correct number of item added' do
      expect(order.items.count).to eq(1)
    end
  end

  describe "#calc_price!" do
    context 'with items' do
      let(:order) { Order.new(user: shared_user, items: shared_order_items) }

      before { order.calc_price! }

      it 'should update correct discount for order' do
        updated_discount = shared_order_items_discount + shared_order_items_membership_discount
        expect(order.discount).to eq(updated_discount)
      end

      it 'should update correct final price for order' do
        updated_final_price = shared_order_items_final_price - shared_order_items_membership_discount
        expect(order.final_price).to eq(updated_final_price)
      end
    end
    
    context 'without items' do
      let(:order) { Order.new(user: shared_user, items: []) }

      before { order.calc_price! }

      it 'should return correct discount' do
        expect(order.discount).to eq(0.0)
      end

      it 'should return correct final price' do
        expect(order.final_price).to eq(0.0)
      end
    end

    context 'without user' do
      let(:order) { Order.new(user: nil, items: shared_order_items) }

      before { order.calc_price! }

      it 'should return correct discount' do
        expect(order.discount).to eq(shared_order_items_discount)
      end

      it 'should return correct final price' do
        expect(order.final_price).to eq(shared_order_items_final_price)
      end
    end
  end
end