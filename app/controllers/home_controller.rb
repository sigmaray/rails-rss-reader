class HomeController < ApplicationController
  def index
    scoped = Item.visible.order('pub_date')
    if params[:feed_id].present?
      @feed = Feed.find(params[:feed_id])
      scoped = scoped.where(feed_id: params[:feed_id])
    end
    @paginator = ReversePagination.new(scoped, params[:page], 10)
  end
end
