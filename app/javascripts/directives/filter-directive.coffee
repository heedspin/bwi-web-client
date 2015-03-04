'use strict'

angular.module('bwi-web-client')
.directive 'bwiFilter', ->
  templateUrl: 'templates/directives/filter.html'
  restrict: 'E'
  controller: ($scope, $element, $attrs, $analytics, $location) ->
    $scope.$watch 'data', (data) ->
      if data
        $scope.years = [data.min_year..data.max_year]

    $scope.startYear = ->
      $analytics.eventTrack 'Select',
        category: 'Start Year Dropdown'
        label: "#{$scope.yearFilters.startYear} #{$location.path()}"

    $scope.endYear = ->
      $analytics.eventTrack 'Select',
        category: 'End Year Dropdown'
        label: "#{$scope.yearFilters.endYear} #{$location.path()}"
