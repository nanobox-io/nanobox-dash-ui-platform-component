module.exports = class PlatformComponentShim

  constructor: () ->

  getComponents : () ->
    [
      @generateComponent nanobox.PlatformComponent.loadBalancer, 'scalable'
      @generateComponent nanobox.PlatformComponent.logger, 'scalable'
      @generateComponent nanobox.PlatformComponent.healthMonitor, 'scalable'
      @generateComponent nanobox.PlatformComponent.router
      @generateComponent nanobox.PlatformComponent.storage
    ]

  generateComponent : (kind, mode="simple") ->
    id: "#{kind}1"
    kind: kind
    mode: mode
    isSplitable: true
    components: [
      {
        id: "9e63d700-c84e-45ed-ba15-ed192fcf92b2"
        uid: "data.portal"
        name: "lucky-lime"
        state: "created"
        serviceType: "default-db"
        scalesHoriz: false
        scalesRedund: false
        isSplitable: true
        generations: [
          {
            id: "data.portal.gen1"
            state: "created"
            status: "online"
            instances: [
              {
                id: 1
                hostId: "test-host-name"
                hostName: "test-host-name"
                state: "created"
                status: "online"
                role: "default"
                serverSpecsId: "512mb"
              }
            ]
          }
        ]
      }
    ]
