IO.foreach('./lib/dictionary.txt') do |line|
  word = line.strip
  Word.create(text: word)
end
