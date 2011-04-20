class JobvideosController < ApplicationController
  # GET /jobvideos
  # GET /jobvideos.xml
  def index
    @jobvideos = Jobvideo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobvideos }
    end
  end

  # GET /jobvideos/1
  # GET /jobvideos/1.xml
  def show
    @jobvideo = Jobvideo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jobvideo }
    end
  end

  # GET /jobvideos/new
  # GET /jobvideos/new.xml
  def new
    @jobvideo = Jobvideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jobvideo }
    end
  end

  # GET /jobvideos/1/edit
  def edit
    @jobvideo = Jobvideo.find(params[:id])
  end

  # POST /jobvideos
  # POST /jobvideos.xml
  def create
    @jobvideo = Jobvideo.new(params[:jobvideo])

    respond_to do |format|
      if @jobvideo.save
        format.html { redirect_to(@jobvideo, :notice => 'Jobvideo was successfully created.') }
        format.xml  { render :xml => @jobvideo, :status => :created, :location => @jobvideo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jobvideo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobvideos/1
  # PUT /jobvideos/1.xml
  def update
    @jobvideo = Jobvideo.find(params[:id])

    respond_to do |format|
      if @jobvideo.update_attributes(params[:jobvideo])
        format.html { redirect_to(@jobvideo, :notice => 'Jobvideo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jobvideo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobvideos/1
  # DELETE /jobvideos/1.xml
  def destroy
    @jobvideo = Jobvideo.find(params[:id])
    @jobvideo.destroy

    respond_to do |format|
      format.html { redirect_to(jobvideos_url) }
      format.xml  { head :ok }
    end
  end
end
