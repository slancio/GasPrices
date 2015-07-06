json.states @states, partial: "api/states/state", as: :state
json.last_updated @states.first.current_price.created_at.to_date