# Controller for /words enpoints. Contains create and destroy categories
#
# @author Margaret Williford

class WordsController < ActionController::API
  # adds a new word to the database and renders JSON of the added word
  #
  # @return [JSON]
  def create
    word_params.each do |word|
      Word.create(text: word)
    end
    render json: Word.last, status: 201
  end

  # Removes a word(found by text params) from dictionary. It will no longer show up
  # as an anagram for other words.
  # @return [status] shows the user a 204 status to confirm word was deleted.
  def destroy
    if params[:text]
      word = Word.find_by(text: params[:text])
      Word.destroy(word.id)
    else
      Word.destroy_all
    end
      render status: 204
  end

  private

  def word_params
    params.require(:words)
  end

end
