'use strict'

angular.module('bwi-web-client')
.directive 'bwiFilter', ->
  templateUrl: 'components/filter/filter.html'
  restrict: 'E'
  controller: ($scope, $element, $attrs) ->
    $scope.years = [
      '2008',
      '2009',
      '2010',
      '2011',
      '2012',
      '2013',
      '2014'
    ]
