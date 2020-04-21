# frozen_string_literal: true

# class Bank
class Bank
  BET = 10

  attr_accessor :amount

  def initialize
    @amount = 0
  end

  def bet
    @amount + BET
  end

  def check_amount?(value)
    return true unless value.zero? || (value - BET).negative?
  end

  def make_a_bet_in_to_a_game_bank
    @amount += BET * 2
  end

  def setting_bank_up
    @amount / 2
  end

  def make_a_bet(gamer)
    return unless check_amount?(gamer.bank)

    gamer.sub_bet(bet)
  end
end
