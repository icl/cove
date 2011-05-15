class TrainingsController < ApplicationController
  # GET /trainings
  # GET /trainings.xml
  def index
    @trainings = Training.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trainings }
    end
  end

  # GET /trainings/new
  # GET /trainings/new.xml
  def new
    @training = Training.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @training }
    end
  end

  # POST /trainings
  # POST /trainings.xml
  def create
    @training = Training.new(params[:training])

    @training.tag_ids = params[:unbound_tag_ids];
    @training.video_ids= params[:unbound_video_ids];

    respond_to do |format|
      if @training.save
        format.html { redirect_to(@training, :notice => 'Training module was successfully created.') }
        format.xml  { render :xml => @training, :status => :created, :location => @training }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @training.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /trainings/1
  # GET /trainings/1.xml
  def show
    @training = Training.find(params[:id])

    if params[:destroy]
      render 'confirm_destroy' and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @training }
    end
  end

  def edit
    @training = Training.find(params[:id])
  end

  def update
    @training = Training.find(params[:id])

    @training.tag_ids = params[:unbound_tag_ids];
    @training.video_ids= params[:unbound_video_ids];

    respond_to do |format|
      if @training.update_attributes(params[:training])
        format.html { redirect_to(@training, :notice => 'Training was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @training.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
   Training.delete(params[:id])
   redirect_to(trainings_url)
  end
end
