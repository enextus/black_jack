# frozen_string_literal: true

# class Bank
class Bank
  attr_accessor :amount

  def initialize
    @amount = 0
    @pay = 10
  end

  def pay
    @amount + @pay
  end

  def check_amount?(value)
    return true unless value.zero? || (value - @pay).negative?
  end

  def make_a_pay_in_to_a_game_bank
    @amount += @pay * 2
  end

  def setting_bank_up
    @amount / 2
  end

  def make_a_bet(gamer)
    return unless check_amount?(gamer.bank)
    gamer.sub_bet(@pay)
  end
end
