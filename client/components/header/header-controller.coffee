'use strict'

angular.module('bwi-web-client')
  .controller 'HeaderCtrl', ($scope, Settings) ->
    $scope.users = [
      {
        name: "kenneth"
      }
      {
        name: "bob"
      }
    ]