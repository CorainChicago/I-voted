class CandidatesController < ApplicationController
  def create
    post_params.each do |candidate|
      if (Candidate.where(zip: zip_params[:zip]).where(name: candidate[1][:name]).count == 0)
          Candidate.create(name: candidate[1][:name], office: candidate[1][:office], party_affiliation: candidate[1][:party], zip: zip_params[:zip])
      end
    end
    render :nothing => true, :status => :ok
  end
  def post_params
    params.require(:results).permit!
  end
  def zip_params
    params.permit(:zip)
  end
end