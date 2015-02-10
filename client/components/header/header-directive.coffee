'use strict'

angular.module('bwi-web-client')
  .directive('bwiHeader', ->
    templateUrl: 'components/header/header.html'
    restrict: 'E'
    controller: ($scope, Auth) ->
      $scope.signout = ->
        Auth.signOut()
  )
