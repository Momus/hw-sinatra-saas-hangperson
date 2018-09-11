class HangpersonGame

  
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_reader :guesses, :word, :wrong_guesses

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError, 'not nil!' if letter.nil?
    letter.downcase!
    raise ArgumentError, 'must be a letter' unless /[a-z]/ =~ letter
    if @word.include? letter
      @guesses.include?(letter) ? false : @guesses << letter
    else
      @wrong_guesses.include?(letter) ? false : @wrong_guesses << letter
    end
  end

  def word_with_guesses
    @word.chars.map { |c| @guesses.include?(c) ? c : '-' }.join
  end

  def self.retrieve_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start do |http|
      return http.post(uri, '').body
    end
  end
end
