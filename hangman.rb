class Hangman
  require 'colorize'
  attr_accessor :words, :current_word, :letters_guessed, :word_guessed, :guess, :counter, :display, :all_words

  def initialize
    @current_word = pick_word_rand.chars
    @letters_guessed = []
    @word_guessed = word_guessed
    @counter = 0
    @display = Display.new
  end

  def all_words
    ["apple", "bacon", "pineapple", "melon", "cheese", "burrito", "avocado"]
  end

  def pick_word_rand
    all_words.sample
  end

  def word_guessed
    Array.new(@current_word.length, "_ ")
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

      grid.each_value {|value| puts value}

    end

    if @counter == 1
      grid[:c][9] = "(".colorize(:red)
      grid[:c][10] = "_".colorize(:red)
      grid[:c][11] = ")".colorize(:red)

      grid.each_value {|value| puts value}


    end

    if @counter == 2
      grid[:d][10] = "|"
      grid[:e][10] = "|"


      grid.each_value {|value| puts value}

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

  def game_over?
    if @word_guessed == @current_word
      puts "Yay, you guessed the word!"
      exit
    elsif @counter >= 6
      puts "Sorry, you didn't figure out the word in time!  Game over."
      exit
    end
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
  attr_accessor :grid, :counter

  def initialize
    blank_screen
    @head = " "
    @body = " "
    @left_arm = " "
    @right_arm = " "
    @left_leg = " "
    @right_leg = " "
    @counter = 0
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

  def draw(counter)

    if counter == 0

    elsif counter == 1
      @grid[:c][10] = "0"

    elsif counter == 2
      @grid[:d][10] = "|"
      @grid[:e][10] = "|"

    elsif counter == 3
      @grid[:d][9] = "\\"

    elsif counter == 4
      @grid[:d][11] = "/"

    elsif counter == 5
      @grid[:f][9] = "/"

    elsif counter == 6
      @grid[:f][11] = "\\"

    end

    return @grid.each_value { |value| puts value }
  end

  def add_body_part(counter)



  end

end

def run

  h = Hangman.new
  puts "Hello, welcome to my hangman game!"
  h.display.draw(0)
  puts "Here is your word: "
  h.draw_current_word
  prompt = "What letter would you like to guess?"
  puts prompt
  input = gets.chomp
  while input != "exit"
    h.draw_current_word(input)
    h.display.draw(h.counter)
    h.game_over?
    puts prompt
    puts
    puts "You've already guessed these letters: #{h.letters_guessed.join(" ")}"
    input = gets.chomp
  end




end

run
