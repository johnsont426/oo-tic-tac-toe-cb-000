class TicTacToe
  def initialize
    @board=Array.new(9, " ")
  end

  WIN_COMBINATIONS=[
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(num)
    num = num.to_i
    num = num - 1
    return num
  end

  def move(position, player_token)
    @board[position]=player_token
  end

  def position_taken?(index)
    if @board[index]==" " || @board[index]=="" || @board[index]==nil
      return false
    elsif @board[index]=="X" || @board[index]=="O"
      return true
    end
  end

  def valid_move?(index)
    if !position_taken?(index) && index.between?(0,8)
      return true
    elsif position_taken?(index) || !index.between?(0,8)
      return false
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter=0
    @board.each do |index|
      if index=="X" || index=="O"
        counter+=1
      end
    end
    return counter
  end

  def current_player
    if turn_count%2==1
      return "O"
    elsif turn_count%2==0
      return "X"
    end
  end

  def won?
    xxx=WIN_COMBINATIONS.detect do |combo|
      combo.all? do |index|
        @board[index]=="X"
      end
    end
    ooo=WIN_COMBINATIONS.detect do |combo|
      combo.all? do |index|
        @board[index]=="O"
      end
    end
    if xxx==nil &&ooo==nil
      return nil
    elsif xxx==nil
      return ooo
    elsif ooo==nil
      return xxx
    end
  end

  def full?
    if !@board.include?(" ")
      return  true
    else
      return false
    end
  end

  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end

  def over?
    if draw?|| won?
      return true
    else
      return false
    end
  end

  def winner
    if won?
      array=won?
      if @board[array[0]]=="O"
        return "O"
      elsif @board[array[0]]=="X"
        return "X"
      end
    else
      return nil
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
