'use strict'

angular.module('bwi-web-client')
.directive 'bwiFilter', ->
  templateUrl: 'directives/filter.html'
  restrict: 'E'
  controller: ($scope, $element, $attrs, $analytics, $location) ->
    $scope.$watch 'data', (data) ->
      if data
        $scope.years = [data.min_year..data.max_year]

        $scope.quarters = [
          { id: 1, name: 'Q1' }
          { id: 2, name: 'Q2' }
          { id: 3, name: 'Q3' }
          { id: 4, name: 'Q4' }
        ]

    $scope.startYear = ->
      $analytics.eventTrack 'Select',
        category: 'Start Year Dropdown'
        label: "#{$scope.yearFilters.startYear} #{$location.path()}"

    $scope.endYear = ->
      $analytics.eventTrack 'Select',
        category: 'End Year Dropdown'
        label: "#{$scope.yearFilters.endYear} #{$location.path()}"

    $scope.startQuarter = ->
      $analytics.eventTrack 'Select',
        category: 'Start Quarter Dropdown'
        label: "#{$scope.yearFilters.startQuarter} #{$location.path()}"

    $scope.endQuarter = ->
      $analytics.eventTrack 'Select',
        category: 'End Quarter Dropdown'
        label: "#{$scope.yearFilters.endQuarter} #{$location.path()}"
