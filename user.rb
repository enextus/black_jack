# frozen_string_literal: true

# class User
class User
  include Validation

  validate :name, :presence
  validate :name, :format, /^[a-z\d]+$/i, '^[a-z\d]+$...'

  attr_reader :name, :cards, :bank

  def initialize(name)
    @name = name
    validate!
    @bank = 100
    @cards = []
  end

  def cards=(cards)
    @cards = cards
  end

  def bank_up(amount)
    @bank += amount
  end

  def set_bet(amount)
    @bank -= amount
  end
end
