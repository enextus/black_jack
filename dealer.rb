# frozen_string_literal: true

# class Dealer
class Dealer
  attr_reader :name
  attr_accessor :cards, :bank

  def initialize(name = 'Dealer')
    @name = name
    @bank = 100
    @cards = []
  end
end
