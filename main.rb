require_relative 'lib/console_interface'
require_relative 'lib/game'

puts "Всем привет!"

# Загрузить случайное слово из файла
word = File.readlines(__dir__ + '/data/words.txt', encoding: 'UTF-8', chomp: true).sample
game = Game.new(word)
console_interface = ConsoleInterface.new(game)

# Пока не закончилась игра
until game.over?
  # Вывести очередное состояние игры
  console_interface.print_out
  # Спросить очередную букву
  letter = console_interface.get_input
  # Обновить состояние игры
  game.play!(letter)
end

# Вывести финальное состояние игры
console_interface.print_out
