class Admin::SearchController < ApplicationController
  def index
    render 'index'
  end

  def show
    if params[:query].blank?
      @results = []
    else
      @query = params[:query]
      @results = Video.search(params[:query].downcase)
      unless params[:video].blank?
        params[:video].each do |key, value| 
          @results = @results.where(key => value) unless value.blank?
        end
      end
      @results
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
end
