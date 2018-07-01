# Controller for /words enpoints. Contains create and destroy categories
#
# @author Margaret Williford

class WordsController < ActionController::API
  # adds a new word to the database and renders JSON of the added word
  #
  # @return [JSON]
  def create
    add_words
    render status: 201
  end

  # Removes a word(found by text params) from dictionary. It will no longer show up
  # as an anagram for other words. If you try to delete a word that does not exist, a 404 renders.
  # @return [status] shows the user a 204 status to confirm word was deleted.
  def destroy
    render status: status
  end

  private

  # Requires a user to pass in words as the key in their request
  def word_params
    params.require(:words)
  end

  # Takes the array of words passed in params and iterates through to create an
  # anagram key if it doesn't exist yet, then add the word.
  def add_words
    word_params.each do |word|
      anagram = Anagram.find_or_create_by(key: word.downcase.chars.sort.join)
      anagram.words.create(text: word)
    end
  end

  # Checks if user is trying to delete a single word or ALL words, then destroys
  def delete_words
    if params[:text]
      Word.destroy(word.id)
    else
      Word.delete_all
    end
  end

  # Finds the word object associated with the text passed in params
  def word
    Word.find_by(text: params[:text])
  end

  # Throws a 404 if user tries to delete a word that is not in the database
  def status
    if params[:text] && word.nil?
      404
    else
      delete_words
      204
    end
  end
end
