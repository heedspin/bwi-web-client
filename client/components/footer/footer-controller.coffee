'use strict'

angular.module('bwi-web-client')
  .controller 'FooterCtrl', ($scope, Settings, $analytics, $location) ->

    $scope.support = ->
      $analytics.eventTrack 'Click',
        category: 'Button'
        label: "Support #{$location.path()}"

    $scope.signUp = ->
      $analytics.eventTrack 'Click',
        category: 'Button'
        label: "Signup #{$location.path()}"
