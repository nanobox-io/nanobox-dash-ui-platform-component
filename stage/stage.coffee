PlatformComponentShim = require './xtra/data-shim'
statsDataSimultor.createFakeStatDataProvider()

dataShim = new PlatformComponentShim()

# ------------------------------------ Event handlers

# Called when the user clicks "Admin"
showAdmin = (id) =>
  for component in components
    if id == component.serviceId
      component.setState "full"
    else
      component.setState "hidden"

resetView = () =>
  for component in components
    component.setState "mini"

# ------------------------------------ Create the components

components = []
$holder    = $ ".component-holder"

loadBalancerData  = {componentKind:nanobox.PlatformComponent.loadBalancer , serviceId:"lasfb1",  isSplitable:false, mode:"simple", showAdminCb:showAdmin, resetViewCb:resetView, componentIds:['9e63d700-c84e-45ed-ba15-ed192fcf92b2'] }
loggerData        = {componentKind:nanobox.PlatformComponent.logger       , serviceId:"l3ag1",   isSplitable:false, mode:"simple", showAdminCb:showAdmin, resetViewCb:resetView, componentIds:['9e63d700-c84e-45ed-ba15-ed192fcf92b2'] }
healthMonitorData = {componentKind:nanobox.PlatformComponent.healthMonitor, serviceId:"hasfem1", isSplitable:false, mode:"simple", showAdminCb:showAdmin, resetViewCb:resetView, componentIds:['9e63d700-c84e-45ed-ba15-ed192fcf92b2'] }
routerData        = {componentKind:nanobox.PlatformComponent.router       , serviceId:"rtxxa1",  isSplitable:true , mode:"simple", showAdminCb:showAdmin, resetViewCb:resetView, componentIds:['9e63d700-c84e-45ed-ba15-ed192fcf92b2'] }
storageData       = {componentKind:nanobox.PlatformComponent.storage      , serviceId:"staf1",   isSplitable:false, mode:"simple", showAdminCb:showAdmin, resetViewCb:resetView, componentIds:['9e63d700-c84e-45ed-ba15-ed192fcf92b2'] }
resolverData      = {componentKind:nanobox.PlatformComponent.resolver     , serviceId:"i929bn",  isSplitable:false, mode:"simple", showAdminCb:showAdmin, resetViewCb:resetView, componentIds:['9e63d700-c84e-45ed-ba15-ed192fcf92b2'] }

console.log loadBalancerData

components.push new nanobox.PlatformComponent( $holder, resolverData )
components.push new nanobox.PlatformComponent( $holder, loadBalancerData )
components.push new nanobox.PlatformComponent( $holder, loggerData )
components.push new nanobox.PlatformComponent( $holder, healthMonitorData )
components.push new nanobox.PlatformComponent( $holder, routerData )
components.push new nanobox.PlatformComponent( $holder, storageData )

for component in components
  component.setState "mini"
  component.on "show-admin", showAdmin
  component.on "close-detail-view", resetView
