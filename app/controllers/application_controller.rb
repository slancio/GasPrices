class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :update_prices

  private

    def update_prices
      price_data = get_aaa_prices
    end

    def get_aaa_prices
      host = "http://fuelgaugereport.aaa.com"
      path = "/import/display.php?lt=state&ls="
      response = scrape(host, path)

      # Put state names and their prices into an array and return it
      [].tap do |aaa_data|
        response.xpath("//tbody/tr").each do |state|
          aaa_data << {}.tap do |state_hash|
            state_hash[:state] = state.css("a").children.first.content
            state_hash[:price] = state.css("td")[1].children.first.content
          end
        end
      end
    end

    def scrape(host, path)
      Nokogiri::HTML(RestClient.get(host + path))
    end
end
