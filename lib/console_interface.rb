class ConsoleInterface
  FIGURES = Dir["#{__dir__}/../data/figures/*.txt"].sort.map { |filename| File.read(filename) }

  def initialize(game)
    @game = game
  end

  def draw
    puts <<~GAME_SCREEN
    
      Слово: #{show_word}
      #{figure}
      Ошибки (#{@game.wrongs.size}): #{show_wrongs}
      Осталось ошибок: #{@game.attempts_left}

    GAME_SCREEN

    if @game.won?
      puts "Победа!"
    elsif @game.lost?
      puts "Помянем молодого, словом было #{@game.word}"
    end
  end

  def get_input
    print "Введите букву: "
    $stdin.gets[0].upcase
  end

  def figure
    return FIGURES[@game.wrongs.size]
  end

  def show_word
    @game.unguessed_letters.map{ |letter| letter == nil ? '_' : letter }.join(' ')
  end

  def show_wrongs
    @game.wrongs.join(', ')
  end
end