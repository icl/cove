class CertificationTestsController < ApplicationController

  before_filter :authenticate_user!

  def show
    @test = CertificationTest.find(params[:id])
  end

  def submit_test
    # calculate test results
    @test = CertificationTest.find(params[:id])
    redirect_to test_results_path(@test)
  end

  def test_results
    @test = CertificationTest.find(params[:id])
  end

end
