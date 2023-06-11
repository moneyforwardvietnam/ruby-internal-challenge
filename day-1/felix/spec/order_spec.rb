require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
  let(:user) { User.new(name: "abc", phone: "1213") }
  let(:item1) { OrderItem.new(price: 10.0, discount: 2.0) }
  let(:item2) { OrderItem.new(product: "voucher", price: 0) }
  let(:item3) { OrderItem.new(product: "Books", price: 15.0, discount: 3.0) }
  let(:items) { [item1, item2, item3] }
  let(:order) { Order.new(user: user, items: items) }

  describe "#add_item" do
    context "When we don't have any items in the order, then we add an item" do
      let(:item_with_nil_price) { OrderItem.new(product: "voucher2") }

      before { order.add_item(item_with_nil_price) }

      it { expect(order.items).to include(item_with_nil_price) }
    end
  end

  describe "#calc_price!" do
    context "when order has item" do
      before do
        order.calc_price!
      end

      context "when member has discount" do
        it "calculates the price correctly" do
          expect(order.price).to eq 25.0
          expect(order.discount).to eq 5.5
          expect(order.final_price).to eq 19.5
        end
      end

      context "when member doesn't have discount" do
        let(:user) {nil}

        it "calculates the price correctly" do
          expect(order.price).to eq 25.0
          expect(order.discount).to eq 5.0
          expect(order.final_price).to eq 20.0
        end
      end
    end

    context "when order has item" do
      let(:items) { [] }

      before do
        order.calc_price!
      end

      it "should return deault price" do
        expect(order.price).to eq 0.0
        expect(order.discount).to eq 0.0
        expect(order.final_price).to eq 0.0
      end
    end
  end
end
