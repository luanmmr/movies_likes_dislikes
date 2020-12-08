class DislikesController < ApplicationController
  def create
    dislike = Dislike.new(user_id: params[:user_id], 
                          episode_id: params[:episode_id])
    if dislike.save
      return redirect_back fallback_location: root_path, 
                           notice: t('.success')
    end
    redirect_back fallback_location: root_path, alert: t('.maximum_dislikes')
  end
end