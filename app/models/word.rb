class Word < ActiveRecord::Base
  attr_accessible :word
  validates :word, :uniqueness => true

  # Return a random word
  def self.random_word(words)
    word = Word.find(1 + rand(Word.all.size))
    words.include?(word.id) ? self.random_word(words) : word
  end

  # Return the word with underscores in place of the letters not in chars
  def underscores(chars, level)
    str = word.split("") - chars
    nw = word.gsub(/[" "]/, '[]')
    if level == 'easy' or str.size == 0
      return nw
    end
    nw.gsub(/["#{str}"]/, '_')
  end

  # Return one random letter, so the word can be more easily guessed
  # Determine what letters remain to be guessed and return one of those letter
  # If all letters have already been guessed, just return a random letter`
  def hint(chars)
    arr_word = word.split("")
    not_guessed_chars = arr_word.uniq - chars.uniq
    not_guessed_chars.size > 0 ? unique_random_letter(chars) : random_letter
  end

  # Returns a random letter contained in the word that is not already in chars
  def unique_random_letter(chars)
    letter = random_letter
    chars.include?(letter) ? unique_random_letter(chars) : letter
  end

  # Returns a random letter contained in the word
  def random_letter
    word[rand(word.size)].downcase
  end
end
