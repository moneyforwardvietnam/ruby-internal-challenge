# frozen_string_literal: true

class Order
  attr_accessor :user, :items, :price, :discount, :final_price

  MEMBERSHIP_DISCOUNT_PERCENT = 2 # %

  # items is an array of OrderItem
  def initialize user: nil, items: []
    @user = user
    @items = items
    @price = 0.0
    @discount = 0.0
    @final_price = 0.0
  end

  # item is a instance of OrderItem
  def add_item item
    @items << item
  end

  def calc_price!
    return if items.empty?

    items.each do |item|
      @price += item.price
      @discount += item.discount
      @final_price += item.final_price
    end

    apply_discount_for_member
  end

  def apply_discount_for_member
    return if user.nil?

    membership_discount = @price * (MEMBERSHIP_DISCOUNT_PERCENT / 100.0)
    @discount += membership_discount
    @final_price -= membership_discount
  end
end