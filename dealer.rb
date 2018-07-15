# frozen_string_literal: true

# class User
class Dealer
  attr_reader :name
  attr_accessor :cards, :bank

  def initialize(name = 'Dealer')
    @name = name
    @bank = 100
    @cards = []
  end
  # methods
end
