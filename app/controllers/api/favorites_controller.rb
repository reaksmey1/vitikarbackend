class Api::FavoritesController < Api::BaseController
    before_action :authenticate_request

    def create
      event = Event.find(params[:event_id])
      current_user.favorites.create!(event: event)
      render json: { success: true, message: "Added to favorites" }
    end

    def destroy
      favorite = current_user.favorites.find_by(event_id: params[:event_id])
      favorite&.destroy
      render json: { success: true, message: "Removed from favorites" }
    end

    def index
      favorites = current_user.favorite_events
      render json: favorites
    end
end
