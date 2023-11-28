# frozen_string_literal: true

# comment
class RatingsController < ApplicationController
  before_action :set_rating, only: %i[show edit update]

  PAGE_SIZE = 15
  def index
    @reverse = params[:reverse] || false
    @page = params[:page]&.to_i || 1
    @last_page = (Rating.count / PAGE_SIZE).ceil
    offset = (@page - 1) * PAGE_SIZE

    @ratings = Rating.order(:created_at).limit(PAGE_SIZE).offset(offset)
    if @reverse
      @ratings = @ratings.reverse_order
    end

    @recent_ratings = Rating.recent
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @top_users = User.top 3
    @top_styles = Style.top 3
  end

  def show
    return unless turbo_frame_request?

    render partial: 'details', locals: { rating: @rating }
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
    # rating = Rating.find params[:id]
    # rating.delete if current_user == rating.user
    # redirect_to user_path(current_user)
    destroy_ids = request.body.string.split(',')
    # Loop through multiple rating IDs and delete them if they exist and belong to the current user
    destroy_ids.each do |id|
      rating = Rating.find_by(id:)
      rating.destroy if rating && current_user == rating.user
    # Rescue in case one of the rating IDs is invalid so we can continue deleting the rest
    rescue StandardError => e
      puts "Rating record has an error: #{e.message}"
    end
    @user = current_user
    respond_to do |format|
      format.html { render partial: '/users/ratings', status: :ok, user: @user }
    end
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end
end
