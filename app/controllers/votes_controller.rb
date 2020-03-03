class VotesController < ApplicationController
  def create
    @vote = current_user.votes.new(vote_params)
    if @vote.save
      render json: {}, status: :created
    else
      render json: { errors: @vote.errors.full_messages }, status: :forbidden
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:message_id)
  end
end
