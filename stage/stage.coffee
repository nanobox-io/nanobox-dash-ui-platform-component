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

components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.loadBalancer , "lb1" )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.logger       , "lg1" )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.healthMonitor, "hm1" )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.router       , "rt1" )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.storage      , "st1" )

for component in components
  component.setState "mini"
  component.on "show-admin", showAdmin
  component.on "close-detail-view", resetView
