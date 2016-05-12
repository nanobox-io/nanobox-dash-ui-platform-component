dataShim         = require './xtra/data-shim'
statsDataSimultor.createFakeStatDataProvider()

# ------------------------------------ Event handlers

# Called when the user clicks "Admin"
showAdmin = (ev, id) =>
  for component in components
    if id == component.componentId
      component.setState "full"
    else
      component.setState "hidden"

resetView = (ev, id) =>
  for component in components
    component.setState "mini"

# ------------------------------------ Create the components

components = []
$holder    = $ ".component-holder"

components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.loadBalancer , "lb1", false )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.logger       , "lg1", false )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.healthMonitor, "hm1", false )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.router       , "rt1", true )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.storage      , "st1", false )

for component in components
  component.setState "mini"
  component.on "show-admin", showAdmin
  component.on "close-detail-view", resetView
