# frozen_string_literal: true

# class MainProgram
class MainProgram
  attr_reader :interface, :user, :dealer

  def initialize(interface)
    @interface = interface
    @deck = Deck.new
  end

  def main_loop
    @interface.clear_display
    @interface.message_welcome
    @interface.drawing_on_new_line

    loop do
      @interface.show_actions
      choice = @interface.getting_choice
      break unless choice != 'exit'

      @interface.clear_display
      action(choice)
      binding.spy
    end
  end

  def action(choice)
    case choice
    when '1'
      create_users
    when '2'
      show_gamer_properties(@user, @deck)
    when '3'
      show_dealer_properties
    when '4'
      start_game
    else
      @interface.message_re_enter
    end

    @interface.drawing_on_borderline
  end

  private

  # #######################  1 - create user && dealer  #######################
  def create_users
    if @user.nil?
      create_users!
    else
      @interface.message_user_exists(@user)
    end
  end

  def create_users!
    user = nil
    dealer = nil

    loop do
      @interface.message_create_user
      name = @interface.getting_name

      user = User.new(name)
      dealer = Dealer.new

      @user = user
      @dealer = dealer

      break
    end
  rescue StandardError => e
    @interface.message_error(e)
    retry
  else
    @interface.message_user_created(user.name)
  end

  def show_gamer_properties(gamer, deck)
    if gamer.nil?
      @interface.message_user_void
    else
      @interface.show_user_properties!(gamer, deck)
    end
  end

  def show_user_properties
    if @user.nil?
      @interface.message_user_void
    else
      @interface.show_user_properties!(@user, @deck)
    end
  end

  def show_dealer_properties
    if @dealer.nil?
      @interface.message_dealer_void
    else
      @interface.show_dealer_properties!(@dealer, @deck, 1)
    end
  end

  # 4 - run game ##############################################################
  def start_game
    if @user.nil?
      @interface.message_user_void
    else
      first_init
      start_game!
    end
  end

  def first_init
    @bank = Bank.new

    gamer_getting_cards(@user)
    gamer_getting_cards(@dealer)

    @bank.make_a_bet(@user)
    @bank.make_a_bet(@dealer)

    @bank.make_a_bet_in_to_a_game_bank
  end

  def start_game!
    @interface.clear_display

    loop do
      show_a_game_bank_amount
      show_gamers_properties

      open_cards if three_cards

      if check_user_lost?
        @interface.message_somebody_has_won(@dealer)
        show_gamers_properties
        break
      elsif check_dealer_lost?
        @interface.message_somebody_has_won(@user)
        show_gamers_properties
        break
      end

      interface_choices

      case @interface.getting_answer
      when 's'
        dealer_move_on
        break
      when 'a'
        gamer_add_card(@user)

        if check_user_lost?
          @interface.message_somebody_has_won(@dealer)
          show_gamers_properties
          break
        elsif check_dealer_lost?
          @interface.message_somebody_has_won(@user)
          show_gamers_properties
          break
        end

        start_game!
        break
      when 'o'
        open_cards
        break
      end
    end
  end

  def show_a_game_bank_amount
    @interface.show_a_game_bank_amount(@bank)
    @interface.drawing_on_borderwave
  end

  def three_cards
    @user.cards.size == 3 && @dealer.cards.size == 3
  end

  def interface_choices
    @interface.message_skip_move
    @interface.message_add_card if @user.cards.size < 3
    @interface.message_open_the_cards
  end

  def show_gamers_properties
    show_user_properties
    @interface.drawing_on_borderwave

    show_dealer_properties
    @interface.drawing_on_borderwave
  end

  def dealer_move_on
    return start_game! if @deck.score_calculate(@dealer.cards) >= 17

    gamer_add_card(@dealer) if @deck.score_calculate(@dealer.cards) < 17
    start_game!
  end

  def open_cards
    dealer_coefficient = 21 - @deck.score_calculate(@dealer.cards)
    user_coefficient = 21 - @deck.score_calculate(@user.cards)

    if dealer_coefficient == user_coefficient
      getting_bank
      @interface.message_nobody_has_won
    elsif dealer_coefficient < user_coefficient
      getting_bank(@dealer)
      @interface.message_somebody_has_won(@dealer)
    elsif dealer_coefficient > user_coefficient
      getting_bank(@user)
      @interface.message_somebody_has_won(@user)
    end

    show_user_properties
    show_dealer_properties
  end

  def getting_bank(gamer = nil)
    if gamer.nil?
      @user.bank_up(@bank.setting_bank_up)
      @dealer.bank_up(@bank.setting_bank_up)
    else
      gamer.bank_up(@bank.amount)
      @bank.amount = 0
    end
  end

  def ask_play_again
    @interface.message_play_again
    replay = @interface.getting_replay
    start_game! if replay == 'y'
  end

  def gamer_add_card(gamer)
    arr = @deck.getting_whole_deck
    card = arr[rand(arr.size)]
    gamer.add_card(card)

    @interface.drawing_on_borderwave
    @interface.mesage_you_drew_the_card
    @interface.drawing_on_new_line
    @interface.draw_card_symbol(card)
    @interface.drawing_on_new_line
    @interface.drawing_on_new_line
  end

  def check_user_lost?
    @deck.score_calculate(@user.cards) > 21
  end

  def check_dealer_lost?
    @deck.score_calculate(@dealer.cards) > 21
  end

  def gamer_getting_cards(gamer)
    gamer.setting_cards(getting_cards)
  end

  def getting_cards
    @deck.random_cards
  end
end
