require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
  
  let(:name) { 'mark' }
  let(:phone) { '081333555' }
  let(:user) { User.new(name: name, phone: phone) }
  let(:order_item_1) { OrderItem.new(product: 'noddle', price: 1.3, discount: 0.0) }
  let(:order_item_2) { OrderItem.new(product: 'rice', price: 2.5, discount: 0.2) }
  let(:items) { [order_item_1, order_item_2] }

  describe 'create a new order' do
    context 'with user and items' do
      let(:order) { Order.new(user: user, items: items) }

      before { order }

      it 'should have correct user' do
        expect(order.user).to eq(user)
        expect(order.user.name).to eq(user.name)
        expect(order.user.phone).to eq(user.phone)
      end

      it 'should have correct order items' do
        expect(order.items.count).to eq(items.count)
        expect(order.items).to include(items.first)
        expect(order.items).to include(items.last)
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
    let(:order) { Order.new(user: user, items: []) }

    before { order.add_item(order_item_1) }
   
    it 'should add correct item into the order' do
      expect(order.items).to include(order_item_1)
    end

    it 'should have correct number of item added' do
      expect(order.items.count).to eq(1)
    end
  end

  describe "#calc_price!" do
    let(:price) { items.sum(&:price) }
    let(:discount) { items.sum(&:discount) }
    let(:final_price) { items.sum(&:final_price) }
    let(:membership_discount) { price * (Order::MEMBERSHIP_DISCOUNT_PERCENT / 100.0) }

    context 'with items' do
      let(:order) { Order.new(user: user, items: items) }

      before { order.calc_price! }

      it 'should update correct discount for order' do
        updated_discount = discount + membership_discount
        expect(order.discount).to eq(updated_discount)
      end

      it 'should update correct final price for order' do
        updated_final_price = final_price - membership_discount
        expect(order.final_price).to eq(updated_final_price)
      end
    end
    
    context 'without items' do
      let(:order) { Order.new(user: user, items: []) }

      before { order.calc_price! }

      it 'should return correct discount' do
        expect(order.discount).to eq(0.0)
      end

      it 'should return correct final price' do
        expect(order.final_price).to eq(0.0)
      end
    end

    context 'without user' do
      let(:order) { Order.new(user: nil, items: items) }

      before { order.calc_price! }

      it 'should return correct discount' do
        expect(order.discount).to eq(discount)
      end

      it 'should return correct final price' do
        expect(order.final_price).to eq(final_price)
      end
    end
  end
end