'use strict'

angular.module('bwi-web-client')
.directive 'bwiTable', ($filter) ->
  templateUrl: 'components/table/table.html'
  restrict: 'E'
  scope:
    options: "="
    filterText: "="
  controller: ($scope, $element, $attrs) ->
    $scope.getDataForCol = (row, key, filterName) ->
      colData = row
      keys = key.split '.'
      for key in keys
        colData = colData[key]

      # apply a filter, if provided
      if filterName
         colData = $filter(filterName) colData

      colData
