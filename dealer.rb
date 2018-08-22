# frozen_string_literal: true

# class Dealer
class Dealer
  attr_reader :name, :cards, :bank

  def initialize(name = 'Dealer')
    @name = name
    @bank = 100
    @cards = []
  end

  def set_cards(cards)
    @cards = cards
  end

  def add_card(card)
    @cards << card
  end

  def bank_up(amount)
    @bank += amount
  end

  def sub_bet(amount)
    @bank -= amount
  end
end
