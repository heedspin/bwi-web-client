'use strict'


angular.module('bwi-web-client')
.service 'urlService', ->
  urlService = @

  urlService.item =
    type: ''
    id: ''
