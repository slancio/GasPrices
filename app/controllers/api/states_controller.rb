module Api
  class StatesController < ApiController
    before_action :update_if_required

    def index
      @states = State.all
      render :index
    end

    def show
      if State.friendly.exists? params[:id]
        @state = State.friendly.find(params[:id])
        render :show
      else
        render json: { error: "Unable to find state with '#{params[:id]}'.\nTry the lowercase abbreviation of the name (e.g., 'ny' for New York)." }, status: :unprocessable_entity
      end
    end

    private

      def update_if_required
        update_prices if State::current_prices.empty?
      end

  end
end