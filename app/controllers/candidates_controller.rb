class CandidatesController < ApplicationController
  def create
    post_params.each do |candidate|
      if (Candidate.where(zip_id: session[:zip]).where(name: candidate[1][:name]).count == 0)
          Candidate.create(name: candidate[1][:name], office: candidate[1][:office], party_affiliation: candidate[1][:party], zip_id: session[:zip])
      end
    end
    render :nothing => true, :status => :ok
  end
  def post_params
    params.require(:results).permit!
  end
end