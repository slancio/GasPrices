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
        render text: "Unable to find state wit '#{params[:id]}'.\nCheck your spelling and parameterize the name (e.g., 'new-york' for New York).", status: 404
      end
    end

    private

      def update_if_required
        update_prices if State::current_prices.empty?
      end

  end
end