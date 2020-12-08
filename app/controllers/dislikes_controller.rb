class DislikesController < ApplicationController
  def create
    dislike = Dislike.new(dislike_params)
    if dislike.save
      verify_like
      return redirect_back fallback_location: root_path, 
                           notice: t('.success')
    end
    redirect_back fallback_location: root_path, alert: t('.maximum_dislikes')
  end

  def destroy
    dislike = Dislike.find_by(user_id: params[:id], episode_id: params[:episode_id])
    dislike.destroy if dislike.present?
    redirect_back fallback_location: root_path, notice: t('.removed')
  end

  private

  def dislike_params
    params.permit(:episode_id, :user_id)
  end

  def verify_like
    like = Like.find_by(dislike_params)
    like.destroy if like.present?
  end
end