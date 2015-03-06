'use strict'

angular.module('bwi-web-client')
  .directive('bwiContributions', ->
    templateUrl: 'directives/contributions.html'
    controller: 'ContributionsCtrl'
    restrict: 'E'
    replace: true
  )
