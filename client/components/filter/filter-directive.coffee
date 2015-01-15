'use strict'

angular.module('bwi-web-client')
  .directive('bwiFilter', ->
    templateUrl: 'components/filter/filter.html'
    controller: 'FilterCtrl'
    restrict: 'E'
  )
