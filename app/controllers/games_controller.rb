require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...8).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    # url = "https://api.github.com/users/ssaunier"
    url_serialized = URI.open(url).read
    check = JSON.parse(url_serialized)
    @valid = check['found']
    @included_in_grid = params[:word].upcase.chars.all? do |character|
      params[:token].include?(character) && params[:word].upcase.count(character) <= params[:token].count(character)
    end
    # raise
  end
end
