IO.foreach('./lib/dictionary.txt') do |line|
  word = line.strip
  anagram = Anagram.find_or_create_by(key: word.downcase.chars.sort.join)
  anagram.words.create(text: word)
end
