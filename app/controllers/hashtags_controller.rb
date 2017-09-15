class HashtagsController < ApplicationController
  def show
    hashtag = params[:id]
    @statuses = Status.where('body LIKE ?', "%##{hashtag}%")
  end
end