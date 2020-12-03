class MoviesController < ApplicationController
    def index
      @movies = JSON.parse(all_movies.body, symbolize_names: true)
    end

    private
    def all_movies
      RestClient.get "https://swapi.dev/api/films/"
    end
end