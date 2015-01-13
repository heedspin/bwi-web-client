angular.module('bwi-web-client')
  .factory "Session", () ->

    this.sessionID = false
    default: true

    return this.sessionID
