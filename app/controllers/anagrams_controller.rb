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

  # allows user to pass text and limit parameters and no other params.
  def anagram_params
    params.permit(:text, :limit)
  end

  # finds the word object associated with the text passed in params
  def word
    Word.find_by(text: params[:text])
  end

  # Returns empty array if the word does not exist, otherwise moves to checking
  # for limit
  def list
    if word
      check_limit
    else
      []
    end
  end

  # limits the result size if a limit param is passed
  def check_limit
    if params[:limit]
      anagrams[0,params[:limit].to_i]
    else
      anagrams
    end
  end

  # Finds all words associated with the sorted key, and then removes the
  # word itself because a word is not its own anagram by definition.
  def anagrams
    word.anagram.words.pluck(:text) - [word.text]
  end
end
