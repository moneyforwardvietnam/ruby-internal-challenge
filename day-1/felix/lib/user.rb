# frozen_string_literal: true

class User
  attr_accessor :name, :phone

  def initialize name:, phone:
    @name = name
    @phone = phone
  end
end