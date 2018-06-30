# Controller for /words enpoints. Contains create and destroy categories
#
# @author Margaret Williford

class WordsController < ActionController::API
  def create
    word_params.each do |word|
      Word.create(text: word)
    end
    render json: Word.all, status: 201
  end

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
