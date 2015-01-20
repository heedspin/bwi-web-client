'use strict'

angular.module('bwi-web-client')
  .controller 'SearchCtrl', ($scope, Settings) ->
    $scope.users = [
      {
        name: "kenneth"
      }
      {
        name: "bob"
      }
    ]

