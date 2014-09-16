class Hangman
  require 'colorize'
  attr_accessor :words, :current_word, :letters_guessed, :word_guessed, :guess, :counter, :display, :all_words

  def initialize
    @current_word = pick_word_rand
    @letters_guessed = []
    @word_guessed = empty_characters
    @counter = 0
    @display = Display.new
  end

  def all_words
    ["apple", "bacon", "pineapple", "melon", "cheese", "burrito", "avocado"]
  end

  def pick_word_rand
    all_words.sample.chars
  end

  def empty_characters
    Array.new(@current_word.count, "_ ")
  end

  def display_guess
    @word_guessed.join(" ")
  end

  def array_to_word(array)
    array.each do |n|
      print n + " "
    end
    puts
  end

  def draw_current_word(guess)
    if check(guess)
      @current_word.each.with_index do |letter, index|
        if letter == guess
          @word_guessed[index] = letter
        end
      end
    end

  end


  def check(letter)
    in_word = @current_word.include? letter
    already_guessed = @letters_guessed.include? letter
    if in_word && !already_guessed
      @letters_guessed.push(letter)
      return true
    elsif !in_word && !already_guessed
      @letters_guessed.push(letter)
      @counter += 1
      return false
    else
      return false
    end

  end


  def game_over?
    if @word_guessed == @current_word
      puts
      puts "Yay, you guessed the word!"
      puts
      exit
    elsif @counter >= 7
      puts
      puts "Sorry, you didn't figure out the word in time!  Game over."
      puts
      exit
    end
  end


end

class Display
  attr_accessor :grid

  def initialize
    @grid = {}
    blank_screen
  end



  def blank_screen
    @grid = {
      a: "     _______         ",
      b: "     |/   |          ",
      c: "     |               ",
      d: "     |               ",
      e: "     |               ",
      f: "     |               ",
      g: "     |               ",
      h: "     |_______        ",
      j: "                     "
    }
  end

  def update_screen(counter)
    if counter == 0

    elsif counter == 1
      @grid[:c][10] = "O"

    elsif counter == 2
      @grid[:d][11] = "/"

    elsif counter == 3

      @grid[:d][10] = "|"

    elsif counter == 4
      @grid[:d][9] = "\\"

    elsif counter == 5

      @grid[:e][10] = "|"


    elsif counter == 6
      @grid[:f][11] = "\\"

    elsif counter == 7

      @grid[:f][9] = "/"

    end
  end

  def draw

    @grid.each_value { |value| puts value }

  end


end

def correct_input?(input, letters_guessed)

  letters = ("a".."z").to_a

  if input.length != 1
    puts "Please input one letter at a time."
    print "> "
  elsif !letters.include? input.downcase
    puts "Sorry that isn't a letter.  Please try again."
    print "> "
  elsif letters_guessed.include? input
    puts "You've already guessed that letter.  Please guess again."
    print "> "
  else
    true
  end

end

def run

  h = Hangman.new
  puts"\e[H\e[2J"
  h.display.draw
  puts h.display_guess
  prompt = "What letter would you like to guess?"
  puts
  puts prompt
  print "> "
  input = gets.chomp
  while input != "exit"


    until correct_input?(input, h.letters_guessed)
      input = gets.chomp
    end



    puts"\e[H\e[2J"



    h.draw_current_word(input)

    if !h.check(input)
      h.display.update_screen(h.counter)
      h.display.draw
    end

    #h.display.draw
    puts h.display_guess


    h.game_over?
    puts
    puts "You've already guessed these letters: #{h.letters_guessed.join(" ")}"
    puts
    puts prompt
    print "> "
    input = gets.chomp
  end

end

run
