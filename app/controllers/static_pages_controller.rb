# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.news_feed.paginate page: params[:page],
      per_page: Settings.perpage
  end

  def help; end

  def about; end

  def testing; end

  def contact; end
end
