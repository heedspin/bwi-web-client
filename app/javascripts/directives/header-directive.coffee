'use strict'

angular.module('bwi-web-client')
  .directive('bwiHeader', ->
    templateUrl: 'templates/directives/header.html'
    restrict: 'E'
    controller: ($scope, Auth) ->
      $scope.signout = ->
        Auth.signOut()
  )
