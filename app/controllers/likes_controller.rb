class LikesController < ApplicationController
  def create
    error_mgs = ''
    if !maximum_likes? && !repeated_movie?
      Like.create(user_id: params[:user_id],
                  episode_id: params[:episode_id])
      return redirect_back fallback_location: root_path,
                           notice: t('.success')
    elsif maximum_likes?
      error_mgs = t('.maximum_likes')
    elsif repeated_movie?
      error_mgs = t('.repeated_movie')
    end
    redirect_back fallback_location: root_path, alert: error_mgs
  end

  private

  def maximum_likes?
    user = User.find(params[:user_id])
    return true if user.likes_total == 2
  end

  def repeated_movie?
    result = Like.where(user_id: params[:user_id],
                        episode_id: params[:episode_id]).length
    return true if result != 0
  end
end
