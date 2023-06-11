# frozen_string_literal: true

class OrderItem
  attr_accessor :product, :price, :discount

  def initialize product: nil, price: nil, discount: nil
    @product = product
    @price = price.to_f
    @discount = discount.to_f
  end

  def final_price
    @final_price ||= price.zero? ? 0.0 : (price - discount)
  end
end
