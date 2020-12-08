class LikesController < ApplicationController
  def create
    like = Like.new(user_id: params[:user_id], 
                    episode_id: params[:episode_id])
    if like.save
      return redirect_back fallback_location: root_path, 
                           notice: t('.success')
    end
    redirect_back fallback_location: root_path, alert: t('.maximum_likes')
  end
end

