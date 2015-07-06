class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :update_prices

  private

    def update_prices
      price_data = validate_price_data(get_aaa_prices)
      unless price_data.nil?

        State.all.each do |state|
        end

      end
    end

    def get_aaa_prices
      host = "http://fuelgaugereport.aaa.com"
      path = "/import/display.php?lt=state&ls="
      response = scrape(host, path)

      # Put state names and their prices into an array and return it
      {}.tap do |aaa_data|
        response.xpath("//tbody/tr").each do |state|
          name = state.css("a").children.first.content
          price = state.css("td")[1].children.first.content
          aaa_data[name] = price
        end
      end
    end

    def validate_price_data(price_data)
      # Make sure we have valid data for all of the states
      state_list = Madison.states.map { |state| state["name"] }
      unless state_list.sort == price_data.keys.sort
        log_scrape_error 'AAA site not returning valid State list'
        return nil
      end

      # validates each price is in correct format
      price_list =  price_data.values.map { |state|
                      state.sub('$', '')[/[0-9]+\.[0-9]{3}/]
                    }.compact
      unless state_list.length == price_list.length
        log_scrape_error 'AAA site not returning valid Price list'
        return nil
      end

      price_data
    end

    def scrape(host, path)
      Nokogiri::HTML(RestClient.get(host + path))
    end

    def log_scrape_error(text)
      Rails.logger.price_scraper.debug(text)
    end
end
