class Admin::SearchController < ApplicationController
  def index
    render 'index'
  end

  def show
    if params[:query].blank?
      @results = []
    else
      @results = VideoTag.search(params[:query].downcase)
    end
  end
end
