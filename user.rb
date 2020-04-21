# frozen_string_literal: true

# class User
class User < Person
  include Validation

  validate :name, :presence
  validate :name, :format, /^[a-z\d]+$/i, '^[a-z\d]+$...'

  attr_reader :name, :cards, :bank

  def initialize(name)
    super name
    validate!
  end
end
