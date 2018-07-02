# Controller for /analytics endpoints. Contains show that lists data on words in store
# @author Margaret Williford
class AnalyticsController < ActionController::API

  def show
    render json: Word.analytics
  end
end
