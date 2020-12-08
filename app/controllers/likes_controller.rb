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

  private

  def like_params
    params.permit(:episode_id, :user_id)
  end

  def verify_dislike
    dislike = Dislike.find_by(like_params)
    dislike.destroy if dislike.present?
  end
end

