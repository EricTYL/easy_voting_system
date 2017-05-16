class CandidatesController < ApplicationController
  def index
    @candids = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to candidates_path, notice: "add candidate successfully"
    else
      render :new
    end
  end

  private
  def candidate_params
    params.require(:candidate).permit(:age, :name, :politics, :party)
  end

end
