require "spec_helper"
require "order"
require "order_item"
require "user"

RSpec.describe Order do
  let(:user) { User.new name: "name", phone: "12345" }
  let(:item1) { OrderItem.new product: "product1", price: 1000, discount: 10 }
  let(:item2) { OrderItem.new product: "product2", price: nil, discount: 10 }
  let(:order) { Order.new }
  
  describe "#add_item" do
    before { order.add_item item1 } 

    it { expect(order.items).to include item1 }     
  end

  describe "#calc_price!" do
    context "when items not exist" do
      it { expect(order.calc_price!).to be_nil } 
    end
    
    context "when items exist" do
      before { order.items = [item1, item2] } 
      
      context "when user not exist" do
        it { expect(order.calc_price!).to be_nil }
      end

      context "when user exist" do
        before { order.user = user } 

        it { expect(order.calc_price!).to eq order.final_price }
      end
    end
  end
end
