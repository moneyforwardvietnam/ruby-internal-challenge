require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
  let(:user) { User.new(name: 'july', phone: '123456789') }
  let(:order_item1) { OrderItem.new(price: 0, discount: 500) }
  let(:order_item2) { OrderItem.new(price: 2000, discount: 500) }
  let(:order) { Order.new }

  describe "#add_item" do
    before do
      order.add_item(order_item1)
      order.add_item(order_item2)
    end

    it "should add the item to the order" do
      expect(order.items.length).to eq 2
      expect(order.items).to include(order_item1, order_item2)
    end
  end

  describe "#calc_price!" do
    context "items empty" do
      before do
        order.calc_price!
      end

      it "should not calc the price" do
        expect(order.price).to eq 0.0
        expect(order.discount).to eq 0.0
        expect(order.final_price).to eq 0.0
      end
    end

    context "items present" do
      context "user nil" do
        let(:order) { Order.new(items: [order_item1, order_item2]) }

        before do
          order.calc_price!
        end

        it "should return correct price without disount" do
          expect(order.price).to eq (order_item1.price + order_item2.price)
          expect(order.discount).to eq (order_item1.discount + order_item2.discount)
          expect(order.final_price).to eq (order_item1.final_price + order_item2.final_price)
        end
      end

      context "user present" do
        let(:order) { Order.new(items: [order_item1, order_item2], user: user) }
        let(:default_member_discount) { 2 }
        let(:membership_discount) {(order_item1.price + order_item2.price) * (default_member_discount / 100.0)}

        before do
          order.calc_price!
        end

        it "should return correct price with disount" do
          expect(order.price).to eq (order_item1.price + order_item2.price)
          expect(order.discount).to eq (order_item1.discount + order_item2.discount + membership_discount)
          expect(order.final_price).to eq (order_item1.final_price + order_item2.final_price - membership_discount)
        end
      end
    end
  end
end