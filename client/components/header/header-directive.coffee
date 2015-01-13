'use strict'

angular.module('bwi-web-client')
  .directive('bwiHeader', ->
    templateUrl: 'components/header/header.html'
    controller: 'HeaderCtrl'
    restrict: 'E'
  )
