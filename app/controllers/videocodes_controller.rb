class VideocodesController < ApplicationController
  # GET /videocodes
  # GET /videocodes.xml
  def index
    @videocodes = Videocode.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videocodes }
    end
  end

  # GET /videocodes/1
  # GET /videocodes/1.xml
  def show
    @videocode = Videocode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @videocode }
    end
  end

  # GET /videocodes/new
  # GET /videocodes/new.xml
  def new
    @videocode = Videocode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @videocode }
    end
  end

  # GET /videocodes/1/edit
  def edit
    @videocode = Videocode.find(params[:id])
  end

  # POST /videocodes
  # POST /videocodes.xml
  def create
    @videocode = Videocode.new(params[:videocode])

    respond_to do |format|
      if @videocode.save
        format.html { redirect_to(@videocode, :notice => 'Videocode was successfully created.') }
        format.xml  { render :xml => @videocode, :status => :created, :location => @videocode }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @videocode.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videocodes/1
  # PUT /videocodes/1.xml
  def update
    @videocode = Videocode.find(params[:id])

    respond_to do |format|
      if @videocode.update_attributes(params[:videocode])
        format.html { redirect_to(@videocode, :notice => 'Videocode was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @videocode.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videocodes/1
  # DELETE /videocodes/1.xml
  def destroy
    @videocode = Videocode.find(params[:id])
    @videocode.destroy

    respond_to do |format|
      format.html { redirect_to(videocodes_url) }
      format.xml  { head :ok }
    end
  end
end
