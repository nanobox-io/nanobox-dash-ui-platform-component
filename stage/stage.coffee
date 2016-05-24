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

components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.loadBalancer , "lasfb1", false )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.logger       , "l3ag1", false )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.healthMonitor, "hasfem1", false )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.router       , "rtxxa1", true )
components.push new nanobox.PlatformComponent( $holder, nanobox.PlatformComponent.storage      , "staf1", false )

for component in components
  component.setState "mini"
  component.on "show-admin", showAdmin
  component.on "close-detail-view", resetView
