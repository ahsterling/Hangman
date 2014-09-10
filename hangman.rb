class Hangman
  require 'colorize'
  attr_accessor :words, :current_word, :letters_guessed

  def initialize
    @words = []
    @current_word = nil
    @letters_guessed = []
    all_letters
    @in_word = nil
  end

  def add_words
    @words.push("apple", "bacon", "pineapple", "melon", "cheese", "burrito", "avocado")
  end

  def pick_word_rand
    @current_word = @words[rand(0..@words.count-1)]
  end

  def all_letters
    @all_letters = ["a" .. "z"]
  end

  def draw_current_word


    @current_word.chars.each do |n|
      #is_it_there = check(n)
      if check(n)
        print n.underline
      else
        print "_"
      end
    end
    #num_letters = @current_word.length
    #puts "_ " * num_letters
  end

  def check(letter)
    if @current_word.include? letter
      #puts "yes, that letter is in the word!"
      @letters_guessed.push(letter)
      true
    else
      #puts "sorry, that's not in the word"
      false
    end

  end

  def draw
    puts """
|
|     _____
|     |/
|     |
|     |
|     |
|     |
|     |
|_____|
"""
  end
end

h = Hangman.new
h.add_words
puts h.words
h.pick_word_rand
puts "Current word is: #{h.pick_word_rand}"
h.draw_current_word
#puts "b"
#h.check("b")
