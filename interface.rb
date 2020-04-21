# frozen_string_literal: true

# class Interface
class Interface
  # initialize constants
  CLEAR = `clear`.freeze
  BORDERLINE = '_' * 50
  BORDERWAVE = '~' * 25
  LINE = ''
  MESSAGES = ['Select the action by entering a number from the list: ',
              '  1 - Create user & dealer.',
              '  2 - Show user properties.',
              '  3 - Show dealer properties.',
              '  4 - Start game.',
              BORDERLINE.to_s,
              'To exit the program, type: exit',
              BORDERLINE.to_s]

  def show_actions
    MESSAGES.each { |action| puts action }
  end

  def clear_display
    puts CLEAR
  end

  ### getting_ ################################################################
  def getting_choice
    gets.chomp.downcase
  end

  def getting_name
    gets.chomp
  end

  def getting_replay
    gets.downcase.strip
  end

  def getting_answer
    gets.downcase.strip
  end

  ### drawing_ ################################################################
  def drawing_card(card)
    print [card.hex].pack('U*') + ', '
  end

  def drawing_on_new_line
    puts LINE
  end

  def drawing_on_borderwave
    puts BORDERWAVE
  end

  def drawing_on_borderline
    puts BORDERLINE
  end

  def draw_card_symbol(card)
    drawing_card(card)
  end

  def draw_cards_symbols(line)
    line.each { |card| drawing_card(card) }
  end

  ### message_ ################################################################
  def message_user_win
    puts 'User win!'
  end

  def mesage_you_drew_the_card
    puts 'You drew the card: '
  end

  def message_welcome
    puts 'Here is the blackjack software.'
  end

  def message_dealer_win
    puts 'Dealer win!'
  end

  def message_add_card
    print '(a)dd a card'
  end

  def message_skip_move
    print 'Would you like to (s)kip, '
  end

  def message_open_the_cards
    puts ' or (o)pen the cards?'
  end

  def message_re_enter
    puts 'Re-enter!'
  end

  def message_user_exists(user)
    puts "User '#{user.name}' already exist. Only one user allowed!"
  end

  def message_create_user
    print 'Enter the user name with format (latin [a-z\d]+): '
  end

  def message_error(exception)
    puts exception.message
  end

  def message_user_created(name)
    puts "\nUser with the name: «#{name}» & «dealer» were successfully created!"
  end

  def message_user_void
    puts 'No user exist. Please create one first!'
  end

  def message_nobody_has_won
    drawing_on_borderline
    puts '*' * 19
    puts '* nobody has won! *'
    puts '*' * 19
    drawing_on_borderline
  end

  def message_somebody_has_won(gamer)
    drawing_on_borderline
    drawing_on_borderline
    puts '*' * 19
    puts "* #{gamer.name} has won! *"
    puts '*' * 19
    drawing_on_borderline
  end

  def message_play_again
    puts 'Would you like to play again? (y/n)'
  end

  def message_no_money
    puts 'no money'
  end

  def message_dealer_void
    puts 'No dealer exist. Please create one first!'
  end

  ### show_ ###################################################################
  def show_user_properties!(user, cards)
    puts "User name: #{user.name}"
    puts "User bank amount: $ #{user.bank}"

    return if user.cards.empty?

    puts 'User cards:'
    drawing_on_new_line
    draw_cards_symbols(user.cards)
    puts "User score is now: #{cards.score_calculate(user.cards)}"
  end

  def show_dealer_properties!(dealer, cards, show = 0)
    puts "Dealer name: #{dealer.name}"
    puts "Dealer bank amount: $ #{dealer.bank}"

    return if dealer.cards.empty?

    puts 'Dealer cards:'
    drawing_on_new_line

    case show
    when 1
      draw_cards_symbols(dealer.cards)
      puts "Dealer score is now: #{cards.score_calculate(dealer.cards)}"
    else
      puts '* *'
      puts 'Actual dealer score: **'
    end
  end

  def show_a_game_bank_amount(game_bank)
    puts "Bank amount: $ #{game_bank.amount}"
  end
end
