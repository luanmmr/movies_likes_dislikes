class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if like.save
      verify_dislike
      return redirect_back fallback_location: root_path,
                           notice: t('.success')
    end
    redirect_back fallback_location: root_path, alert: t('.maximum_likes')
  end

  def destroy
    like = Like.find_by(user_id: params[:id], episode_id: params[:episode_id])
    like.destroy if like.present?
    redirect_back fallback_location: root_path, notice: t('.removed')
  end

  private

  def like_params
    params.permit(:episode_id, :user_id)
  end

  def verify_dislike
    dislike = Dislike.find_by(like_params)
    dislike.destroy if dislike.present?
  end
end
