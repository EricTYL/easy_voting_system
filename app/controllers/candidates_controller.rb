class CandidatesController < ApplicationController
  def index
    @candids = Candidate.all
  end
end
