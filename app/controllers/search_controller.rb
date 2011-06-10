class SearchController < ApplicationController
  def show
    #@query = params[:video] ? params[:video][:query] : ""
    @query = params[:query] ? params[:query][0] : ""
    if @query.blank?
      @results = Video.where("")
    else
      @results = Video.search(@query.downcase)
    end
    unless params[:video].blank?
      params[:video].each do |key, value| 
        @results = @results.where(key => value) unless value.blank?
      end
    end
    
    respond_to do |format|
      format.html do
        if request.xhr?
          render :partial => "search_results"
        else
          render 'show'
        end
      end
    end
  end
end
