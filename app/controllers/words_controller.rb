# Controller for /words enpoints. Contains create and destroy categories
#
# @author Margaret Williford

class WordsController < ActionController::API
  # adds a new word to the database and renders JSON of the added word
  #
  # @return [JSON]
  def create
    add_words
    render json: Word.last, status: 201
  end

  # Removes a word(found by text params) from dictionary. It will no longer show up
  # as an anagram for other words. If you try to delete a word that does not exist, a 404 renders.
  # @return [status] shows the user a 204 status to confirm word was deleted.
  def destroy
    render status: status
  end

  private

  def word_params
    params.require(:words)
  end

  def add_words
    word_params.each do |word|
      anagram = Anagram.find_or_create_by(key: word.downcase.chars.sort.join)
      anagram.words.create(text: word)
    end
  end

  def delete_words
    if params[:text]
      Word.destroy(word.id)
    else
      Word.destroy_all
    end
  end

  def word
    Word.find_by(text: params[:text])
  end

  def status
    if params[:text] && word.nil?
      404
    else
      delete_words
      204
    end
  end
end
