PlatformComponentShim = require './xtra/data-shim'
statsDataSimultor.createFakeStatDataProvider()

dataShim = new PlatformComponentShim()

# ------------------------------------ Event handlers

# Called when the user clicks "Admin"
showAdmin = (id) =>
  for component in components
    if id == component.componentId
      component.setState "full"
    else
      component.setState "hidden"

resetView = () =>
  for component in components
    component.setState "mini"

# ------------------------------------ Create the components

components = []
$holder    = $ ".component-holder"

loadBalancerData  = {componentKind:nanobox.PlatformComponent.loadBalancer , componentId:"lasfb1",  isSplitable:false, showAdminCb:showAdmin, resetViewCb:resetView }
loggerData        = {componentKind:nanobox.PlatformComponent.logger       , componentId:"l3ag1",   isSplitable:false, showAdminCb:showAdmin, resetViewCb:resetView }
healthMonitorData = {componentKind:nanobox.PlatformComponent.healthMonitor, componentId:"hasfem1", isSplitable:false, showAdminCb:showAdmin, resetViewCb:resetView }
routerData        = {componentKind:nanobox.PlatformComponent.router       , componentId:"rtxxa1",  isSplitable:true , showAdminCb:showAdmin, resetViewCb:resetView }
storageData       = {componentKind:nanobox.PlatformComponent.storage      , componentId:"staf1",   isSplitable:false, showAdminCb:showAdmin, resetViewCb:resetView }

components.push new nanobox.PlatformComponent( $holder, loadBalancerData )
components.push new nanobox.PlatformComponent( $holder, loggerData )
components.push new nanobox.PlatformComponent( $holder, healthMonitorData )
components.push new nanobox.PlatformComponent( $holder, routerData )
components.push new nanobox.PlatformComponent( $holder, storageData )

for component in components
  component.setState "mini"
  component.on "show-admin", showAdmin
  component.on "close-detail-view", resetView
