# frozen_string_literal: true

# black jack game software | a school project
# main file
# initialize constants
CLEAR = `clear`.freeze
BORDERLINE = '_' * 50
BORDERWAVE = '~' * 25
LINE = ''

# require of while required files
require_relative 'interface'
require_relative 'validation'
require_relative 'game_bank'
require_relative 'deck'
require_relative 'user'
require_relative 'dealer'
require_relative 'controller'

# a class Interface object is created here
interface = Interface.new

# a class Controller object is created here
controller = Controller.new(interface)

# game start
controller.main_loop
