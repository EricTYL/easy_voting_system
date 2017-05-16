class CadidatesController < ApplicationController
  def index
    @candids = Candidate.all
  end
end
