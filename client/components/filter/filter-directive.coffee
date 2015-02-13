'use strict'

angular.module('bwi-web-client')
.directive 'bwiFilter', ->
  templateUrl: 'components/filter/filter.html'
  restrict: 'E'
  controller: ($scope, $element, $attrs, $analytics, $location) ->
    $scope.years = [
      '2008',
      '2009',
      '2010',
      '2011',
      '2012',
      '2013',
      '2014'
    ]

    $scope.startYear = ->
      $analytics.eventTrack 'Select',
        category: 'Start Year Dropdown'
        label: "#{$scope.yearFilters.startYear} #{$location.path()}"

    $scope.endYear = ->
      $analytics.eventTrack 'Select',
        category: 'End Year Dropdown'
        label: "#{$scope.yearFilters.endYear} #{$location.path()}"
