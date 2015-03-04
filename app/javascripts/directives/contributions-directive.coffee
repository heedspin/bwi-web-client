'use strict'

angular.module('bwi-web-client')
  .directive('bwiContributions', ->
    templateUrl: 'templates/directives/contributions.html'
    controller: 'ContributionsCtrl'
    restrict: 'E'
    replace: true
  )
