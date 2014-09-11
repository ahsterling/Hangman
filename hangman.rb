class Hangman
  require 'colorize'
  attr_accessor :words, :current_word, :letters_guessed, :word_guessed, :guess, :counter

  def initialize
    @all_words = []
    @current_word = []
    @letters_guessed = []
    @word_guessed = nil
    @counter = 0
    add_words
  end

  def add_words
    @all_words.push("apple", "bacon", "pineapple", "melon", "cheese", "burrito", "avocado")
  end

  def pick_word_rand
    @current_word = @all_words[rand(0..@all_words.count-1)].chars
    @word_guessed = Array.new(@current_word.length, "_ ")
  end

  def array_to_word(array)
    array.each do |n|
      print n + " "
    end
    puts
  end

  def draw_current_word(guess= nil)
    if guess == nil
      array_to_word(@word_guessed)
    else
      if check(guess)
        @current_word.each.with_index do |letter, index|
          if letter == guess
            @word_guessed[index] = letter
          end
        end

      end

      array_to_word(@word_guessed)



    puts
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
    elsif already_guessed
      return false
    else
      return false
    end

  end



  def draw

    grid = {
      a: "     _______         ",
      b: "     |/   |          ",
      c: "     |               ",
      d: "     |               ",
      e: "     |               ",
      f: "     |               ",
      g: "     |               ",
      h: "     |_______        ",
    }


    if counter == 0

      puts grid[:a]
      puts grid[:b]
      puts grid[:c]
      puts grid[:d]
      puts grid[:e]
      puts grid[:f]
      puts grid[:g]
      puts grid[:h]
    end

    if @counter == 1
      grid[:c][9] = "("
      grid[:c][10] = "_"
      grid[:c][11] = ")"


      puts grid[:a]
      puts grid[:b]
      puts grid[:c]
      puts grid[:d]
      puts grid[:e]
      puts grid[:f]
      puts grid[:g]
      puts grid[:h]

    end

    if @counter == 2
      grid[:d][10] = "|"
      grid[:e][10] = "|"

      puts grid[:a]
      puts grid[:b]
      puts grid[:c]
      puts grid[:d]
      puts grid[:e]
      puts grid[:f]
      puts grid[:g]
      puts grid[:h]
    end

#     puts """
#
#      _____
#      |/  |
#      |  (_)
#      |   |
#      | \\|/
#      |   |
#      |  / \
#  ____|______
# """
  end

  def win?
    if @word_guessed == @current_word
      puts "Yay, you guessed the word!"
      exit
    elsif @counter >= 6
      puts "Sorry, you didn't figure out the word in time!  Game over."
      exit
    end

  end

  def die?
    if @counter >= 6
      puts "Sorry, you didn't figure out the word in time!  Game over. "
    end
    exit
  end

end

class Display
  attr_accessor :grid

  def initialize
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
    }
  end

  def draw

    @grid.each

  end

  def add_body_part(counter)

    if counter == 0
      puts @grid

    elsif counter == 1
      @grid[:c][9] = "("
      @grid[:c][10] = "_"
      @grid[:c][11] = ")"

      puts @grid

    elsif counter == 2
      @grid[:d][10] = "|"
      @grid[:e][10] = "|"

      puts @grid

    end

  end

end

def run

  h = Hangman.new
  d = display
  puts "Hello, welcome to my hangman game!  Here is your word:"
  puts
  h.pick_word_rand
  h.draw_current_word
  h.draw
  prompt = "What letter would you like to guess?"
  puts prompt
  input = gets.chomp

  while input != "exit"
    h.draw_current_word(input)
    h.draw
    h.win?
    puts h.counter
    puts prompt
    puts "You've already guessed these letters: #{h.letters_guessed.join(" ")}"
    input = gets.chomp
  end

  exit


end

run
