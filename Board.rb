class Board

  attr_accessor :rows
  attr_accessor :feedback
  attr_accessor :code  
  attr_accessor :current_row
  attr_accessor :turns

  @@pieces = ["Y", "O", "R", "B", "G", "W"]

  def initialize(turns=12)
    @rows = []
    @feedback = []	
	@current_row = 0	
	@turns = turns		
  end  
  
  def self.pieces
  	return @@pieces
  end

  #checks to see if the given code is valid
  def valid_code?(code)
	#if the code isnt 4 letters: invalid	
	if code.length != 4
	  return false	    
	else
	  code.each do |letter| 
	    #if any letter isnt a color option: invalid
	    if !@@pieces.include?(letter.upcase)
	  	  return false
	    end
	  end
	  #otherwise: valid
	  true

	end
  end

  def generate_code
  	array = []
  	array[0] = @@pieces[rand(5)]
  	array[1] = @@pieces[rand(5)]
  	array[2] = @@pieces[rand(5)]
  	array[3] = @@pieces[rand(5)]
  	@code = array
  end

  def increase_row
    @current_row += 1
  end

  def new_guess(array)	
	rows[@current_row] = array
  end

  def new_feedback
	
	row = @rows[@current_row]
	current = []
	code_counts =  Hash.new(0)
	row_counts = Hash.new(0)
	@code.each {|color| code_counts[color] += 1 }
	row.each {|color| row_counts[color] += 1 }	

	0.upto(@code.length - 1) do |index|	 	  
	  color = row[index]
 	  
	  if @code[index] == color
	  	current << 2
	  	code_counts[color] -= 1
	  	row_counts[color] -= 1
	  elsif code_counts[color] > 0	  	
	  	if(code_counts[color] >= row_counts[color])
	  	  current << 1
	  	else
	  	  current << 0
	  	  row_counts[color] -= 1
	  	end
	  else
	  	current << 0
	  end

	end  

	current.sort!
    @feedback[@current_row] = current	  	
	increase_row
  end



  def draw(display=false)
  	board = ""
    0.upto(@turns-1) do |num|
    	row = @rows[num]
    	feedback = @feedback[num]
      board += "  __________________________\n" +
      		   "  #{row[0]}  #{row[1]}" + 
      		   "  #{row[2]}  #{row[3]}\t"
   	  

   	  board += "  #{feedback[0]}  #{feedback[1]}" +
   	  		   "  #{feedback[2]}  #{feedback[3]}\n"   	            
   	end

   	if display
   	  board += "  CODE:\n  #{@code[0]}  #{code[1]}" + 
   	  	       "  #{code[2]}  #{code[3]}\n" +
   	           "  __________________________"
   	end
   	puts board
  end  	 	

  
  def set  	
	  number = @turns-1
	  number.times do 	  
	  @rows.push([])	  
	  @feedback.push([])
	end
  end
end