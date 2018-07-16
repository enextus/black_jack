# frozen_string_literal: true

# class Interface
class Interface
  def show_actions
    messages = ['Select the action by entering a number from the list: ',
                '  1 - Create user & dealer.',
                '  2 - Show user properties.',
                '  3 - Show dealer properties.',
                '  4 - Show whole cards.',
                '  5 - Start game.',
                BORDERLINE.to_s,
                'To exit the menu, type: exit',
                BORDERLINE.to_s]
    messages.each { |action| puts action }
  end

  def message_welcome
    puts 'Here is the blackjack software.'
  end

  def clear_display
    puts CLEAR
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

  def message_user_win
    puts 'User win!'
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

  def error_message(exception)
    puts exception.message
  end

  def message_user_created(name)
    puts "\nUser with the name: «#{name}» & «dealer» were successfully created!"
  end

  def user_void
    puts 'No user exist. Please create one first!'
  end

  def show_user_properties!(user, cards)
    puts "User name: #{user.name}"
    puts "User bank amount: $ #{user.bank}"

    return if user.cards.empty?
    puts 'User cards:'
    drawing_on_new_line
    cards.puts_cards_symbols(user.cards)
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
      cards.puts_cards_symbols(dealer.cards)
      puts "Dealer score is now: #{cards.score_calculate(dealer.cards)}"
    else
      puts '* *'
      puts 'Actual dealer score: **'
    end
  end

  def dealer_void
    puts 'No dealer exist. Please create one first!'
  end

  def show_a_game_bank_amount(game_bank)
    puts "Game bank amount: $ #{game_bank.amount}"
  end

  def message_nobody_has_won
    drawing_on_borderline
    puts '*' * 19
    puts '* nobody has won! *'
    puts '*' * 19
    drawing_on_borderline
  end

  def message_somebody_has_won(somebody)
    drawing_on_borderline
    drawing_on_borderline
    puts '*' * 19
    puts "* #{somebody.name} has won! *"
    puts '*' * 19
    drawing_on_borderline
  end

  def message_play_again
    puts 'Would you like to play again? (y/n)'
  end

  def message_no_money
    puts 'no money'
  end
end
