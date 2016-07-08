class Game
  require_relative 'Player.rb'
  require_relative 'Board.rb'

  attr_accessor :board
  attr_accessor :player
  attr_accessor :computer
  attr_accessor :turn_number 
  attr_accessor :player_role
  
  @@stats = {:wins => 0, :losses => 0}
  
  def initialize(turns=12)
    @board = Board.new(turns)
    @player = Player.new("Player")
    @turn_number = 1
    @board.generate_code
    @board.set
    #@board.draw     
  end

  def self.stats
    return @@stats
  end

  def select_role
    puts "Would you like to make the code or break the code? " +
         "(Type make or break and press enter!)"
    selection = gets.upcase!.chomp
    if selection == "MAKE"
    	@player_role = "maker"
    elsif selection == "BREAK"
    	@player_role = "breaker"
    else
    	invalid
    end
  end

  def set_code
  	array = []
    done = false
  	while(!done)
  	  puts "Please select a four letter code: ('Y', 'O', 'B','R', 'G', 'W')"
  	  array = gets.chomp.upcase!.split("")
  	  if @board.valid_code?(array)
  	    @board.code = array
  	    done = true  	      	    
  	  else
  	    invalid  
  	  end
  	end  
  end
  
  def next_turn
  	@turn_number += 1
  end

  def game_over?
  	if @board.rows[-1] == []
  	  winning_feedback = [2,2,2,2]
  	  if @board.feedback.include?(winning_feedback)
  	    true
  	  end  	  
  	else
  	  true
  	end
  end

  def display_winner
    if @board.rows.include?(@board.code)
      if @player_role == "breaker"
        puts "\n\nPlayer 1 wins!"
        @@stats[:wins] += 1
      else
    	puts "\n\nComputer wins!"
    	@@stats[:losses] += 1
      end
    else
      if @player_role == "breaker"
        puts "\n\nComputer wins!"
        @@stats[:losses] += 1
      else
    	puts "\n\nPlayer 1 wins!"
    	@@stats[:wins] += 1
      end
    end
  end 

  def invalid
  	puts "That is an invalid selection!"
  end

  def take_turn
  	puts "Please enter a new 4 letter guess: ('Y' 'O' 'R' 'B' 'G' 'W')"
  	guess = gets.chomp.upcase!.split("")
  	if @board.valid_code?(guess)
  	  @board.new_guess(guess)
  	  @board.new_feedback
  	  if game_over?
  	  	@board.draw(true)
  	  	display_winner
  	  else
  	  	@board.draw
  	    next_turn
  	  end 
  	else
  	  invalid
  	end
  end

  def computer_turn
  	#puts "\n\nTurn: #{@turn_number}"
  	@board.new_guess(generate_guess)
  	@board.new_feedback
  	#@board.draw
  	next_turn
  	#sleep(3)
  end

  def generate_guess
  	guess = []
  	good_guess = false
  	while(!good_guess)
  	  0.upto(@board.code.length - 1) do |index|
  	    color = @board.code[index]
  	    last_guess = @board.rows[@board.current_row - 1][index]
  	    if color == last_guess
  	  	  guess[index] = last_guess
  	    else
  	  	  guess[index] = Board.pieces[rand(5)]
  	    end
  	  end
  	  if(!@board.rows.include?(guess))
  		good_guess = true
  	  end
    end
  	guess
  end

end

wins = 0
games = 0

while games < 1000
	game = Game.new(7)
	game.player_role = "maker"
	if game.player_role == "maker"
	  game.board.generate_code
	  while(!game.game_over?)
	    game.computer_turn
	  end
	else
	  while(!game.game_over?)	
	    game.take_turn
	  end
	end
	game.display_winner
	games += 1
end

puts Game.stats.to_s


