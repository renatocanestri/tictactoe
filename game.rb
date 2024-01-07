# frozen_string_literal: true

# This class is used to represent the Tic Tac Toe game
class Game
  attr_accessor :board_array, :player1, :player2

  def initialize
    @board_array = (1..9).to_a
    welcome_player
    display_board(@board_array)
    create_players
    play_game
  end

  def welcome_player
    puts 'Welcome to Tic Tac Toe!'
  end

  def display_board(board_array)
    puts " #{board_array[0]} | #{board_array[1]} | #{board_array[2]} "
    puts '---+---+---'
    puts " #{board_array[3]} | #{board_array[4]} | #{board_array[5]} "
    puts '---+---+---'
    puts " #{board_array[6]} | #{board_array[7]} | #{board_array[8]} "
  end

  def create_players
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
  end

  def player_input(current_player)
    puts "#{current_player.name} (#{current_player.marker}), enter your move in the command line:"
    current_player_move = gets.chomp.to_i
    if valid_position_played?(current_player_move)
      deal_with_valid_position(current_player_move, current_player)
    else
      deal_with_invalid_position(current_player_move, current_player)
    end
  end

  def valid_position_played?(player_move)
    (1..9).cover?(player_move) && @board_array[player_move - 1] != 'X' && @board_array[player_move - 1] != 'O'
  end

  def deal_with_valid_position(current_player_move, current_player)
    @board_array[current_player_move - 1] = current_player.marker
  end

  def deal_with_invalid_position(current_player_move, current_player)
    until valid_position_played?(current_player_move)
      puts 'Invalid move, try again:'
      current_player_move = gets.chomp.to_i
    end
    @board_array[current_player_move - 1] = current_player.marker
  end

  def draw?
    return true if @board_array.all? { |element| %w[X O].include?(element) }

    false
  end

  def check_rows
    [0, 3, 6].each do |i|
      return true if @board_array[i] == @board_array[i + 1] && @board_array[i] == @board_array[i + 2]
    end
    false
  end

  def check_columns
    3.times do |i|
      return true if @board_array[i] == @board_array[i + 3] && @board_array[i] == @board_array[i + 6]
    end
    false
  end

  def check_diagonals
    return true if @board_array[0] == @board_array[4] && @board_array[0] == @board_array[8]
    return true if @board_array[2] == @board_array[4] && @board_array[2] == @board_array[6]

    false
  end

  def win?
    check_rows || check_columns || check_diagonals
  end

  def end_game_check(current_player)
    if win?
      puts "Congratulations, #{current_player.name} wins!"
      return true
    elsif draw?
      puts 'It\'s a draw!'
      return true
    end
    false
  end

  def play_game
    current_player = @player1
    loop do
      player_input(current_player)
      display_board(@board_array)
      break if end_game_check(current_player)

      current_player = current_player == @player1 ? @player2 : @player1
    end
  end
end

# This class is used to represent/create the players
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end
Game.new
