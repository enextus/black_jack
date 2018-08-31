# frozen_string_literal: true

# module Deck
class Deck
  attr_reader :score_weight

  def initialize
    @deck_count = 2
    @spades =   %w[1F0A1 1F0A2 1F0A3 1F0A4 1F0A5 1F0A6 1F0A7 1F0A8 1F0A9 1F0AA 1F0AB 1F0AD 1F0AE]
    @hearts =   %w[1F0B1 1F0B2 1F0B3 1F0B4 1F0B5 1F0B6 1F0B7 1F0B8 1F0B9 1F0BA 1F0BB 1F0BD 1F0BE]
    @diamonds = %w[1F0C1 1F0C2 1F0C3 1F0C4 1F0C5 1F0C6 1F0C7 1F0C8 1F0C9 1F0CA 1F0CB 1F0CD 1F0CE]
    @clubs    = %w[1F0D1 1F0D2 1F0D3 1F0D4 1F0D5 1F0D6 1F0D7 1F0D8 1F0D9 1F0DA 1F0DB 1F0DD 1F0DE]
    @score_weight = 0
  end

  def whole_deck
    (@spades + @hearts + @diamonds + @clubs).shuffle
  end

  def getting_whole_deck
    @spades + @hearts + @diamonds + @clubs
  end

  def random_cards
    @random_cards = getting_whole_deck.sample(@deck_count)
  end

  def mapping(value)
    case value
    when /[23456789]/
      value.to_i
    when /[ABDE]/
      10
    when '1'
      1
    end
  end

  def score_calculate(cards)
    @c_new = []

    cards.each_with_index do |value, index|
      @c_new[index] = mapping(value[4..4])
    end

    sum = @c_new.sum

    if @c_new.include? 1
      sum + 10 <= 21 ? sum + 10 : sum
    else
      sum
    end
  end
end
