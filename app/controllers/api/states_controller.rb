module Api
  class StatesController < ApiController
    before_action :update_if_required

    def index
      @states = State.all
      render :index
    end

    def show
      @state = State.friendly.find(params[:id])
      render :show
    end

    private

      def update_if_required
        update_prices if State::current_prices.empty?
      end

  end
end