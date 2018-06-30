# Controller for /anagrams endpoints. Contains index that lists all anagrams for a
# given word
# @author Margaret Williford
class AnagramsController < ActionController::API
  # renders JSON of all associated anagrams within the dictionary for a given word.
  #
  # @return [JSON]
  def index
    render json: {"anagrams": anagrams}
  end

  private
  def anagram_params
    params.permit(:text, :limit)
  end

  def word
    Word.find_by(text: params[:text])
  end

  def anagrams
    if word
      check_limit
    else
      []
    end
  end

  def check_limit
    if params[:limit]
      word.anagrams[0,params[:limit].to_i]
    else
      word.anagrams
    end
  end
end
