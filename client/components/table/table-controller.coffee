'use strict'

angular.module('bwi-web-client')
  .controller 'TableCtrl', ($scope, Settings) ->
    # header still hides without using session service