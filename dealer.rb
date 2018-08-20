# frozen_string_literal: true

# class Dealer
class Dealer
  attr_reader :name, :cards, :bank

  def initialize(name = 'Dealer')
    @name = name
    @bank = 100
    @cards = []
  end

  def cards=(cards)
    @cards = cards
  end

  def bank_up(win_prize)
    @bank += win_prize
  end

  def set_bet(amount)
    @bank -= amount
  end
end
