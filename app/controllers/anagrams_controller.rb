# Controller for /anagrams endpoints. Contains index that lists all anagrams for a
# given word
# @author Margaret Williford
class AnagramsController < ActionController::API
  # renders JSON of all associated anagrams within the dictionary for a given word.
  #
  # @return [JSON]
  def index
    render json: {"anagrams": list}
  end

  private
  def anagram_params
    params.permit(:text, :limit)
  end

  def word
    Word.find_by(text: params[:text])
  end

  def list
    if word
      check_limit
    else
      []
    end
  end

  def check_limit
    if params[:limit]
      anagrams[0,params[:limit].to_i]
    else
      anagrams
    end
  end

  def anagrams
    word.anagram.words.pluck(:text) - [word.text]
  end
end
