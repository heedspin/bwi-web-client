'use strict'

angular.module('bwi-web-client')
  .controller 'HeaderCtrl', ($scope, Settings) ->
    # header still hides without using session service