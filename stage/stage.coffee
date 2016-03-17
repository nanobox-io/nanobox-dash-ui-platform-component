dataShim = require './xtra/data-shim'

$holder  = $ ".component-holder"

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

for id in dataShim.ids
  component = new nanobox.PlatformComponent( $holder, id )
  component.setState "mini"
  component.on "show-admin", showAdmin
  component.on "close-detail-view", resetView
  components.push component
