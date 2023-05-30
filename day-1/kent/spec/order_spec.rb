require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
  subject(:order) do
    described_class.new(user: user)
  end

  let(:user) { User.new(name: "name", phone: "1234") }
  let(:item1) { OrderItem.new(product: "product1", price: 100) }
  let(:item2) { OrderItem.new(product: "product2", price: 200, discount: 20) }
  let(:item3) { OrderItem.new(product: "product1", price: 0) }

  describe "#add_item" do
    it "adds item correctly" do
      expect(order.items).to eq []
      order.add_item item1
      expect(order.items).to eq [item1]
      order.add_item item2
      expect(order.items).to eq [item1, item2]
    end
  end

  describe "#calc_price!" do
    shared_examples "order calculation" do
      it do
        items.each do |item|
          order.add_item item
        end
        order.calc_price!
        expect(order.final_price).to eq final_price
      end
    end

    context "when items is nil" do
      include_examples "order calculation" do
        let(:items) { [] }
        let(:final_price) { 0.0 }
      end
    end

    context "when is member" do
      include_examples "order calculation" do
        let(:items) { [item1, item2, item3] }
        let(:final_price) { 274.0 }
      end
    end

    context "when is not member" do
      let(:user) { nil }

      include_examples "order calculation" do
        let(:items) { [item1, item2, item3] }
        let(:final_price) { 280.0 }
      end
    end
  end
end