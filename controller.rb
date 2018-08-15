# frozen_string_literal: true

# class Controller
class Controller .
  attr_reader :interface, :user, :dealer

  def initialize(interface)
    @interface = interface
    @user = nil
    @dealer = nil
    @game_bank = nil
    @deck = Deck.new
  end

  def main_loop
    @interface.clear_display
    @interface.message_welcome
    @interface.drawing_on_new_line
    loop do
      @interface.show_actions
      choice = gets.chomp.downcase
      break if choice == 'exit'
      @interface.clear_display
      action(choice)
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
    user, dealer = nil

    loop do
      @interface.message_create_user
      name = gets.chomp

      user = User.new(name)
      dealer = Dealer.new

      @user = user
      @dealer = dealer

      break
    end
  rescue StandardError => exception
    @interface.error_message(exception)
    retry
  else
    @interface.message_user_created(user.name)
  end

  # ####################  2 - show gamers properties  #########################
  def show_gamer_properties(gamer, deck)
    if gamer.nil?
      @interface.user_void
    else
      @interface.show_user_properties!(gamer, deck)
    end
  end

  def show_user_properties
    if @user.nil?
      @interface.user_void
    else
      @interface.show_user_properties!(@user, @deck)
    end
  end

  def show_dealer_properties
    if @dealer.nil?
      @interface.dealer_void
    else
      @interface.show_dealer_properties!(@dealer, @deck, 1)
    end
  end

  # ##########################   4 - run game #################################
  def start_game
    if @user.nil?
      @interface.user_void
    else
      first_init
      start_game!
    end
  end

  def first_init
    @game_bank = GameBank.new

    gamer_getting_cards(@user)
    gamer_getting_cards(@dealer)

    make_a_bet(@user)
    make_a_bet(@dealer)
    make_a_game_bank_pay
  end

  def start_game!
    @interface.clear_display
    loop do
      @interface.show_a_game_bank_amount(@game_bank)
      @interface.drawing_on_borderwave
      show_user_properties
      @interface.drawing_on_borderwave
      show_dealer_properties
      @interface.drawing_on_borderwave
      @interface.message_skip_move
      @interface.message_add_card if @user.cards.size < 3
      @interface.message_open_the_cards

      answer = gets.downcase.strip

      case answer
      when 's'
        dealer_move_on
        break
      when 'a'
        user_add_card
        start_game!
        break
      when 'o'
        open_cards
        break
      end
    end
  end

  def dealer_move_on
    if @deck.score_calculate(@dealer.cards) >= 17
      start_game!
    elsif @deck.score_calculate(@dealer.cards) < 17
      dealer_add_card
      start_game!
    end
  end

  def open_cards
    dealer_koeffizient = 21 - @deck.score_calculate(@dealer.cards)
    user_koeffizient = 21 - @deck.score_calculate(@user.cards)

    if dealer_koeffizient == user_koeffizient
      getting_prize
      @interface.message_nobody_has_won
    elsif dealer_koeffizient < user_koeffizient
      getting_prize(@dealer)
      @interface.message_somebody_has_won(@dealer)
    elsif dealer_koeffizient > user_koeffizient
      getting_prize(@user)
      @interface.message_somebody_has_won(@user)
    end

    show_user_properties
    show_dealer_properties
  end

  def getting_prize(player = nil)
    if player.nil?
      @win_prize = @game_bank.amount / 2
      @user.bank, @dealer.bank = @win_prize, @win_prize
    else
      player.bank += @game_bank.amount
      @game_bank.amount = 0
    end
  end

  def ask_play_again
    @interface.message_play_again
    replay = gets.downcase.strip
    start_game! if replay == 'y'
  end

  def user_add_card
    arr = @deck.getting_whole_deck
    card = arr[rand(arr.size)]
    @user.cards << card
    @interface.drawing_on_borderwave
    puts 'You drew the card: '
    @interface.drawing_on_new_line
    @deck.puts_card_symbol(card)
    @interface.drawing_on_new_line
    @interface.drawing_on_new_line
  end

  def dealer_add_card
    arr = @deck.getting_whole_deck
    card = arr[rand(arr.size)]
    @dealer.cards << card
    @interface.drawing_on_borderwave
    puts 'You drew the card: '
    @interface.drawing_on_new_line
    @deck.puts_card_symbol(card)
    @interface.drawing_on_new_line
    @interface.drawing_on_new_line
  end

  def check_user_win?
    @deck.score_calculate(@user.cards) == 21
  end

  def check_user_lost?
    @deck.score_calculate(@user.cards) > 21
  end

  def message_game_win
    puts 'YES! You win!'
  end

  def message_game_over
    puts 'Bust! You lose. Game over!'
  end

  def gamer_getting_cards(gamer)
    gamer.cards = getting_cards
  end

  def getting_cards
    @deck.random_cards
  end

  def make_a_bet(gamer)
    if @game_bank.check_amount?(gamer.bank)
      gamer.bank = gamer.bank - @game_bank.pay
    else
      @interface.message_no_money
    end
  end

  def make_a_game_bank_pay
    @game_bank.amount += @game_bank.pay * 2
  end
end
