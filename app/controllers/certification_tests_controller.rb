class CertificationTestsController < ApplicationController

  before_filter :authenticate_user!

  def show
    @test = CertificationTest.find(params[:id])
    @certification = @test.certification
    @video = @test.video
    # required for Aaron's jwplayer
    tag = @certification.tag
    @tags = [tag]
    @tagDisplayNames = [tag.name]
    @jsonStr = '{"id":' + tag.id.to_s() + ',' + ' "name":' + '\'' + tag.name + '\''+'},'
  end

  def submit_test
    # calculate test results
    @test = CertificationTest.find(params[:id])
    @test.user.certifications << @test.certification if @test.score >= 0.75 
    redirect_to test_results_path(@test)
  end

  def test_results
    @test = CertificationTest.find(params[:id])
  end
  
  def tag
    @tagging = CertificationTestTag.new(:certification_test_id => params[:id], :tag_id => params[:tag_id], :start_time => params[:start_time], :end_time => params[:end_time])
    
    respond_to do |format|
      if @tagging.save
        format.json { render :json => @tagging, :status => :created }
      else
        format.json { render :json => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end

end
