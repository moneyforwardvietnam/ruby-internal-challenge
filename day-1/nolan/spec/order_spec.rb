require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
  let(:user) { User.new(name: "nolan", phone: "66770128") }
  let(:item_1) { OrderItem.new(product: "product_1", price: 25.5, discount: 5.5) }
  let(:item_2) { OrderItem.new(product: "product_2", price: 36.6, discount: 6.6) }
  let(:item_3) { OrderItem.new(product: "product_3", price: 0, discount: 0) }
  let(:item_4) { OrderItem.new(product: "product_4", price: nil, discount: nil) }
  let(:membership_discount) { 1.242 } # 2% of (25.5 + 36.6 + 0 + 0)

  describe "#add_item" do
    it "should add item to list correctly" do
      order = described_class.new(user: user)
      order.add_item(item_1)
      expect(order.items.length).to eq 1
      order.add_item(item_2)
      expect(order.items.length).to eq 2
      order.add_item(item_3)
      expect(order.items.length).to eq 3
      order.add_item(item_4)
      expect(order.items.length).to eq 4
     
      # check order of item after add
      expect(order.items).to match_array [item_1, item_2, item_3, item_4]
    end
  end

  describe "#calc_price!" do
    let(:items) { [item_1, item_2, item_3, item_4] }

    context "list items is empty" do
      before do
        @order = described_class.new(user: user)
        @order.calc_price!
      end

      it "should not perform calculation" do
        expect(@order.price).to eq 0
        expect(@order.discount).to eq 0
        expect(@order.final_price).to eq 0
      end
    end

    context "list items is present" do
      context "user is empty" do
        before do
          @order = described_class.new(items: items)
          @order.calc_price!
        end

        it "should perform calculation price but do not apply membership discount" do
          expect(@order.price).to eq items.map {|item| item.price}.sum
          expect(@order.discount).to eq items.map {|item| item.discount}.sum
          expect(@order.final_price).to eq items.map {|item| item.final_price}.sum
        end
      end

      context "user is present" do
        before do
          @order = described_class.new(user:user, items: items)
          @order.calc_price!
        end

        it "should perform calculation price & apply membership discount" do
          expect(@order.price).to eq items.map {|item| item.price}.sum
          expect(@order.discount).to eq (items.map {|item| item.discount}.sum + membership_discount)
          expect(@order.final_price).to eq (items.map {|item| item.final_price}.sum - membership_discount)
        end
      end
    end
  end
end
