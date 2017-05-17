class CandidatesController < ApplicationController

  before_action :find_candidate, only: [:edit, :update, :destroy, :vote]

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
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: "edit candidate successfully"
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy if @candidate
    redirect_to candidates_path, notice: "delete candidate successfully"
  end

  def vote
    # without account system, use ip as identification to ensure a person can vote once
    if ip_is_unique(request.remote_ip)
      @candidate.vote_logs.create(ip_address: request.remote_ip) if @candidate
      #    render :index 
      # it doesn't work because there's no candids variable here, error appear when render index.html.erb
      redirect_to candidates_path, notice: "vote successfully"
    else
      redirect_to candidates_path, notice: "You have already voted before!"
    end
  end

  private
  def candidate_params
    params.require(:candidate).permit(:age, :name, :politics, :party)
  end

  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end

  def ip_is_unique(ip)
    true unless VoteLog.find_by(ip_address: ip)
  end
end
