class LikesController < ApplicationController
    def create
      if !maximum_likes? && !repeated_movie?
        Like.create(user_id: params[:user_id], 
                    episode_id: params[:episode_id])
      else
        if maximum_likes?
          return redirect_back fallback_location: root_path, 
                               alert: t('.maximum_likes')
        else
          return redirect_back fallback_location: root_path, 
                               alert: t('.repeated_movie')
        end
      end

      return redirect_back fallback_location: root_path, 
                           notice: t('.success')
    end

    private
    def maximum_likes?
      user = User.find(params[:user_id])
      
      if user.likes_total == 2
        return true
      else
        return false
      end
    end

    def repeated_movie?
      result = Like.where(user_id: params[:user_id], 
                          episode_id: params[:episode_id]).length
      if result != 0
        return true
      else
        return false
      end
    end

end