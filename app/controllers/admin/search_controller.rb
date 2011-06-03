class Admin::SearchController < ApplicationController
  def index
    render 'index'
  end

  def show
    if params[:query].blank?
      @results = []
    else
      @query = params[:query]
      @results = VideoTag.search(params[:query].downcase)
      ids = []
      @results.each do | vt|
        ids << vt.video_id
      end
      unless params[:video].blank?
        debugger
        @results = Video.where(:id => ids)
        params[:video].each do |key, value| 
          @results = @results.where(key => value) unless value.blank?
        end
      end
      @results
    end
  end
end
