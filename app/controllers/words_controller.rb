class WordsController < ActionController::API
  def create
    word_params.each do |word|
      Word.create(text: word)
    end
    render status: 201
  end

  private

  def word_params
    params.require(:words)
  end

end
