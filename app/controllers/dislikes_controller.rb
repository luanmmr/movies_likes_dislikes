class DislikesController < ApplicationController
    def create
        if !maximum_dislikes? && !repeated_movie?
          Dislike.create(user_id: params[:user_id], 
                      episode_id: params[:episode_id])
        else
          if maximum_dislikes?
            return redirect_back fallback_location: root_path, 
                                 alert: t('.maximum_dislikes')
          else
            return redirect_back fallback_location: root_path, 
                                 alert: t('.repeated_movie')
          end
        end
  
        return redirect_back fallback_location: root_path, 
                             notice: t('.success')
      end
  
      private
      def maximum_dislikes?
        user = User.find(params[:user_id])
        
        if user.dislikes_total == 2
          return true
        else
          return false
        end
      end
  
      def repeated_movie?
        result = Dislike.where(user_id: params[:user_id], 
                            episode_id: params[:episode_id]).length
        if result != 0
          return true
        else
          return false
        end
      end
end