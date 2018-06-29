class AnagramsController < ActionController::API
  def index
    if word
      render json: {"anagrams": word.anagrams}
    else
      render json: {"anagrams": []}
    end
  end

  private
  def word
    Word.find_by(text: params[:text])
  end
end
