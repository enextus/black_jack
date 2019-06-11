# frozen_string_literal: true

# class Dealer
class Dealer < Person
  attr_reader :name, :cards, :bank

  def initialize(name = 'Dealer')
    super(name)
  end
end
 
