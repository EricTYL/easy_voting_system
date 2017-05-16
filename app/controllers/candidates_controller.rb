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

  def edit
    @candidate = Candidate.find_by(id: params[:id])
  end

  def update
    @candidate = Candidate.find_by(id: params[:id])

    if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: "edit candidate successfully"
    else
      render :edit
    end
  end

  def destroy
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.destroy if @candidate
    redirect_to candidates_path, notice: "delete candidate successfully"
  end

  def vote
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.vote_logs.create(ip_address: request.remote_ip) if @candidate
    #    render :index 
    # it doesn't work because there's no candids variable here, error appear when render index.html.erb
    redirect_to candidates_path, notice: "vote successfully"
  end

  private
  def candidate_params
    params.require(:candidate).permit(:age, :name, :politics, :party)
  end

end
