dataShim         = require './xtra/data-shim'

# ------------------------------------ Event handlers

# Called when the user clicks "Admin"
showAdmin = (ev, id) =>
  for component in components
    if id == component.id
      component.setState "full"
    else
      component.setState "hidden"

resetView = (ev, id) =>
  for component in components
    component.setState "mini"

# ------------------------------------ Create the components

components = []
$holder    = $ ".component-holder"

for id in dataShim.ids
  component = new nanobox.PlatformComponent( $holder, id )
  component.setState "mini"
  component.updateLiveStats statsDataSimultor.generateFakeLiveStats()  # Load fake data (only included for testing : hourly-stats/rel/data-shim.js)
  # Events
  component.on "show-admin", showAdmin
  component.on "close-detail-view", resetView

  components.push component
