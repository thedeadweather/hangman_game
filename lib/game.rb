class Game
  TOTAL_ERRORS_ALLOWED = 7

  # конструктор с переменными:
  # слово по буквам и массив попыток
  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  # массив попыток - массив загаданных букв
  def errors
    return @user_guesses - normalized_letters
  end

  # длина массива ошибок
  def errors_made
    return errors.length
  end

  # 7 - кол-во ошибок
  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  # вернем букву если она есть в попытках либо nil
  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(normalize_letter(letter))
          letter
        else
          nil
        end
      end

    return result
  end

  # вернуть измененную букву "ё" на "е" и "й" на "и"
  def normalize_letter(letter)
    case letter
    when "Ё"
      "Е"
    when "Й"
      "И"
    else
      letter
    end
  end

  # вернуть массив с измененными буквами
  def normalized_letters
    @letters.map { |i| normalize_letter(i) }
  end

  # сыграть: добавить букву в попытки
  def play!(letter)
    if !over? && !@user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def won?
    return (normalized_letters - @user_guesses).empty?
  end

  def lost?
    return errors_allowed == 0
  end

  def over?
    return won? || lost?
  end

  # вернуть слово
  def word
    return @letters.join
  end
end
