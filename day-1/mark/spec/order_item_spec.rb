require "spec_helper"
require "order_item"

RSpec.describe OrderItem do

  let(:product) { 'milk' }
  let(:price) { 4.25 }
  let(:discount) { 1.30 }

  describe 'create new order item' do
    context 'with product, price, and discount' do
      let(:order_item) { OrderItem.new(product: product, price: price, discount: discount) }
      
      before { order_item }

      it 'should have correct product' do
        expect(order_item.product).to eq(product)
      end

      it 'should have correct price amount' do
        expect(order_item.price).to eq(price)
      end

      it 'should have price as Float' do
        expect(order_item.price.is_a? Float).to be true
      end

      it 'should have correct discount amount' do
        expect(order_item.discount).to eq(discount)
      end

      it 'should have discount as Float' do
        expect(order_item.discount.is_a? Float).to be true
      end
    end

    context 'without product, price, and discount' do
      let(:order_item) { OrderItem.new }

      before { order_item }

      it 'should not have any product' do
        expect(order_item.product).to be_nil
      end

      it 'should have price equal zero' do
        expect(order_item.price).to eq(0.0)
      end

      it 'shoule have price as Float' do
        expect(order_item.price.is_a? Float).to be true
      end

      it 'should have discount equal zero' do
        expect(order_item.discount).to eq(0.0)
      end

      it 'should have discount as Float' do
        expect(order_item.discount.is_a? Float).to be true
      end
    end
  end

  describe '#final_price' do
    context 'item price is zero' do
      let(:order_item) { OrderItem.new(product: product, price: 0.0, discount: discount) }
      
      before { order_item }

      it 'should return zero' do
        expect(order_item.final_price).to eq(0.0)
      end

      it 'should return Float' do
        expect(order_item.final_price.is_a? Float).to be true
      end
    end

    context 'item price is not zero' do
      let(:order_item) { OrderItem.new(product: product, price: price, discount: discount) }

      before { order_item }

      it 'should return correct price' do
        final_price = order_item.price.zero? ? 0.0 : order_item.price - order_item.discount
        expect(order_item.final_price).to eq(final_price)
      end

      it 'should return Float' do
        expect(order_item.final_price.is_a? Float).to be true
      end
    end
  end
end