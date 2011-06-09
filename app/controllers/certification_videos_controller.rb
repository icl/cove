class CertificationVideosController < ApplicationController

  before_filter :authenticate_user!

  def seed
    @certification_video = CertificationVideo.find(params[:id])
    @certification = @certification_video.certification
    @video = @certification_video.video
    @tags = [@certification_video.certification.tag]
    @tagDisplayNames = [@tags[0].name]      
  end
  
  def post_seed
    @certification_video = CertificationVideo.find(params[:id])
    @certification = @certification_video.certification
    @certification_video.seeder = current_user
    if @certification_video.save
      redirect_to(tag_path(@certification.tag), :notice => 'Certification seeded.')
    else
      # go to error page
    end
  end

end
