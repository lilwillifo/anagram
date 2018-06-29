class AnagramsController < ActionController::API
  def index
    word = Word.find_by(text: params[:text])
    render json: word.anagrams
  end
end
