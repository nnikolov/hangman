class Word < ActiveRecord::Base
  attr_accessible :word
  validates :word, :uniqueness => true

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