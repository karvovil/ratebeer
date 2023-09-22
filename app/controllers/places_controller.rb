class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:city] = params[:city]
      render :index, status: 418
    end
  end

  def show
    @place = Rails.cache.read(session[:city].downcase).detect { |p| p["id"] = params[:id] }
  end
end
