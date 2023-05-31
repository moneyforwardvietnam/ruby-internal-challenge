require "spec_helper"

RSpec.shared_context 'order_items' do
  include_context 'product'

  let(:shared_order_item_1) { OrderItem.new(product: shared_product, price: 1.3, discount: 0.0) }
  let(:shared_order_item_2) { OrderItem.new(product: shared_product, price: 2.5, discount: 0.2) }

  let(:shared_order_items) { [shared_order_item_1, shared_order_item_2] }

  let(:shared_order_items_price) { shared_order_items.sum(&:price) }
  let(:shared_order_items_discount) { shared_order_items.sum(&:discount) }
  let(:shared_order_items_final_price) { shared_order_items.sum(&:final_price) }
  let(:shared_order_items_membership_discount) { shared_order_items_price * Order::MEMBERSHIP_DISCOUNT_PERCENT / 100.0 }
end