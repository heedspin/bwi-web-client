'use strict'

angular.module('bwi-web-client')
  .directive('bwiContributions', ->
    templateUrl: 'components/contributions/contributions.html'
    controller: 'ContributionsCtrl'
    restrict: 'E'
    replace: true
  )
