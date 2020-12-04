class MoviesController < ApplicationController
  before_action :all_movies

  def index
  end

  def report
    @likes_group = Like.group(:episode_id).count
    @infos_likes = Array.new(2) {Array.new(@likes_group.length)}
    report_likes(@likes_group, @infos_likes)
    @dislikes_group = Dislike.group(:episode_id).count
    @infos_dislikes = Array.new(2) {Array.new(@dislikes_group.length)}
    report_dislikes(@dislikes_group, @infos_dislikes) 
  end

  private

  def all_movies
    resp = RestClient.get 'https://swapi.dev/api/films/'
    @movies = JSON.parse(resp.body, symbolize_names: true)
  end

  def report_likes(likes_group, infos_likes)   
    x = 0
    likes_group.each do |movie, likes|
      @movies[:results].each do |m|
        if m[:episode_id] == movie
          infos_likes[0][x] = m[:title]
        end 
      end 
      infos_likes[1][x] = likes
      x += 1
    end
  end

  def report_dislikes(dislikes_group, infos_dislikes)   
    x = 0
    dislikes_group.each do |movie, likes|
      @movies[:results].each do |m|
        if m[:episode_id] == movie
          infos_dislikes[0][x] = m[:title]
        end 
      end 
      infos_dislikes[1][x] = likes
      x += 1
    end
  end

end
