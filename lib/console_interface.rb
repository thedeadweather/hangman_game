require 'colorize'

class ConsoleInterface
  FIGURES =
    Dir[__dir__ + '/../data/figures/*.txt'].
      sort.
      map { |file_name| File.read(file_name) }

  # на входе объект игры
  def initialize(game)
    @game = game
  end
  # вывод состояния (макета)
  def print_out
    puts <<~STATUS
      Слово: #{word_to_show.colorize(:light_blue)}
      #{figure.colorize(:yellow)}
      Ошибки (#{@game.errors_made}): #{errors_to_show.colorize(:red)}
      У вас осталось ошибок: #{@game.errors_allowed}
    STATUS

    # вывод выйграл или проиграл
    if @game.won?
      puts "Поздравляем, вы выиграли!".colorize(:light_green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:light_red)
    end
  end

  # вывод картинки в соответстии с кол-вом ошибок
  def figure
    return FIGURES[@game.errors_made]
  end

  # вывод отгаданных букв
  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter == nil
          "__"
        else
          letter
        end
      end

    return result.join(' ')
  end

  # вывод ошибок
  def errors_to_show
    return @game.errors.join(', ')
  end

  # ввод варианта
  def get_input
    print "Введите следующую букву: "
    letter = gets[0].upcase
    return letter
  end
end
