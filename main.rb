# frozen_string_literal: true

# black jack game software | a school project

# require all required files
require_relative 'interface'
require_relative 'validation'
require_relative 'bank'
require_relative 'deck'
require_relative 'person'
require_relative 'user'
require_relative 'dealer'
require_relative 'mainprogram'

# a class Interface object is created here
interface = Interface.new

# a class Controller object is created here
mainprogram = MainProgram.new(interface)

# game start
mainprogram.main_loop
