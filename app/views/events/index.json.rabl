object false
node(:events) do
  partial("events/show.json.rabl", :object => @events)
end
