require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
  let(:user){ User.new name: 'ron', phone: '091212121' }
    
  let(:item_1) { OrderItem.new product: "Mercedes C200", price: 2.3, discount: 0.3 }
  let(:item_2) { OrderItem.new product: "Porsche 911", price: 9.2, discount: 0.2 }
  let(:item_3) { OrderItem.new product: "legs", price: 0, discount: 0.0 }
  
  describe "#add_item" do
    let(:items) { [item_1] }
    let(:order) { Order.new user: user, items: items }

    it_behaves_like "check items in order"

    it "should add right items" do
      order.add_item item_2
      expect(order.items.size).to eq 2
    end
  end

  describe "#calc_price!" do

    context "with items is empty" do
      let(:items) { [] }
      let(:order) { Order.new user: user, items: items }
      let(:results) {
        {
          price: 0.0,
          final_price: 0.0,
          discount: 0.0
        }
      }
      it_behaves_like "check items in order"
      it_behaves_like "check result after run calc_price"
    end

    context "with user is nil" do
      let(:items) { [item_1, item_2, item_3] }
      let(:order) { Order.new user: nil, items: items }
      let(:results) {
        {
          price: 11.5,
          final_price: 11,
          discount: 0.5
        }
      }

      it_behaves_like "check items in order"
      it_behaves_like "check result after run calc_price"
    end

    context "with user is not nil and items is not empty" do
      let(:items) { [item_1, item_2, item_3] }
      let(:order) { Order.new user: user, items: items }
      let(:results) {
        {
          price: 11.5,
          final_price: 10.77,
          discount: 0.73
        }
      }
      
      it_behaves_like "check items in order"
      it_behaves_like "check result after run calc_price"
    end

  end
end