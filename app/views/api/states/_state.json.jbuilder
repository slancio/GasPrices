json.name state.name
json.current_price ("%.3f" % state.current_price.price)
json.last_updated state.current_price.created_at.to_date