json.name state.name
json.code Madison.get_abbrev(state.name).upcase
json.current_price ("%.3f" % state.current_price.price)