class Admin::SearchController < ApplicationController
  def index
    render 'index'
  end

  def show
    if params[:query].blank?
      @results = []
    else
      @query = params[:query]
      result_tags = VideoTag.search(params[:query].downcase)
      unless params[:video].blank?
        params[:video].each do |key, value| 
          @results = @results.where(key => value)
        end
      end
    end
  end
end
