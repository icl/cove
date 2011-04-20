class JobcodesController < ApplicationController
  # GET /jobcodes
  # GET /jobcodes.xml
  def index
    @jobcodes = Jobcode.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobcodes }
    end
  end

  # GET /jobcodes/1
  # GET /jobcodes/1.xml
  def show
    @jobcode = Jobcode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jobcode }
    end
  end

  # GET /jobcodes/new
  # GET /jobcodes/new.xml
  def new
    @jobcode = Jobcode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jobcode }
    end
  end

  # GET /jobcodes/1/edit
  def edit
    @jobcode = Jobcode.find(params[:id])
  end

  # POST /jobcodes
  # POST /jobcodes.xml
  def create
    @jobcode = Jobcode.new(params[:jobcode])

    respond_to do |format|
      if @jobcode.save
        format.html { redirect_to(@jobcode, :notice => 'Jobcode was successfully created.') }
        format.xml  { render :xml => @jobcode, :status => :created, :location => @jobcode }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jobcode.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobcodes/1
  # PUT /jobcodes/1.xml
  def update
    @jobcode = Jobcode.find(params[:id])

    respond_to do |format|
      if @jobcode.update_attributes(params[:jobcode])
        format.html { redirect_to(@jobcode, :notice => 'Jobcode was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jobcode.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobcodes/1
  # DELETE /jobcodes/1.xml
  def destroy
    @jobcode = Jobcode.find(params[:id])
    @jobcode.destroy

    respond_to do |format|
      format.html { redirect_to(jobcodes_url) }
      format.xml  { head :ok }
    end
  end
end
