class MoviesController < ApplicationController
  before_action :all_movies, only: %i[index chart]
  before_action :group_likes_dislikes, only: %i[chart]

  def index; end

  def chart
    mount_all_array
    mount_likes_array
    mount_dislikes_array
  end

  private

  def all_movies
    resp = RestClient.get 'https://swapi.dev/api/films/'
    @movies = JSON.parse(resp.body, symbolize_names: true)
  end

  def group_likes_dislikes
    @likes_group = Like.group(:episode_id).count
    @dislikes_group = Dislike.group(:episode_id).count
    @all_group = @likes_group.merge(@dislikes_group)
  end

  def mount_likes_array
    @likes_chart = Array.new(2) { Array.new(@likes_group.length) }
    x = 0
    @likes_group.each do |movie, likes|
      @movies[:results].each do |m|
        @likes_chart[0][x] = m[:title] if m[:episode_id] == movie
      end
      @likes_chart[1][x] = likes
      x += 1
    end
  end

  def mount_dislikes_array
    @dislikes_chart = Array.new(2) { Array.new(@dislikes_group.length) }
    x = 0
    @dislikes_group.each do |movie, likes|
      @movies[:results].each do |m|
        @dislikes_chart[0][x] = m[:title] if m[:episode_id] == movie
      end
      @dislikes_chart[1][x] = likes
      x += 1
    end
  end

  def mount_all_array
    @unordened_all = Array.new(2) { Array.new(@all_group.length) }
    x = 0
    @all_group.each_key do |episode|
      @movies[:results].each do |m|
        @unordened_all[0][x] = m[:title] if m[:episode_id] == episode
      end
      @unordened_all[1][x] = Like.where(episode_id: episode).count +
                             Dislike.where(episode_id: episode).count
      x += 1
    end
    order_all_array
  end

  def order_all_array
    @ordened_all_chart = Array.new(2) { Array.new(@all_group.length) }
    0.upto(@unordened_all[0].length - 1) do |n|
      max_value = @unordened_all[1].max
      @ordened_all_chart[1][n] = max_value
      index = @unordened_all[1].find_index(max_value)
      @ordened_all_chart[0][n] = @unordened_all[0][index]
      @unordened_all[0].slice!(index)
      @unordened_all[1].slice!(index)
    end
  end
end
