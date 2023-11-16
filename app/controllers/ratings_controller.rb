# frozen_string_literal: true

# comment
class RatingsController < ApplicationController
  before_action :set_rating, only: %i[show edit update destroy]

  def index
    @ratings = Rating.all
    @recent_ratings = Rating.recent
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @top_users = User.top 3
    @top_styles = Style.top 3
  end

  def show
    if turbo_frame_request?
      render partial: 'details', locals: { rating: @rating } 
    end
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end
end
