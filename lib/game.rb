class Game
  MAX_ATTEMPTS = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def attempts_left
    MAX_ATTEMPTS - wrongs.size
  end

  def normalize_letter(letter)
    letter = 'E' if letter == 'Ё'
    letter = 'И' if letter == 'Й'
    return letter
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

  def try!(letter)
    unless over? || @user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def unguessed_letters
    result = @letters.map { |letter| @user_guesses.include?(normalize_letter(letter)) ? letter : nil }
  end

  def word
    @letters.join
  end

  def wrongs
    return @user_guesses - normalized_letters
  end

  def over?
    won? || lost?
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def lost? 
    attempts_left == 0
  end
end
