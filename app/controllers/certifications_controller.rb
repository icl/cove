class CertificationsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def take_test
    c = Certification.find(params[:id])
  
    if c.seeded? then
      video = c.certification_videos.sample;  
      test = CertificationTest.create(:certification_video => video, :user => current_user)
      redirect_to show_test_path(@test)
    else
      redirect_to(jobs_path, :notice => 'Selected certification has not yet been seeded.')
    end
  end
end
