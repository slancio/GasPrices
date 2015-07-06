json.states do
  json.partial! "api/states/state", state: @state
end
json.last_updated @state.current_price.created_at.to_date