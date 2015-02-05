'use strict'

angular.module('bwi-web-client')
.directive 'bwiTable', ($filter) ->
  templateUrl: 'components/table/table.html'
  restrict: 'E'
  scope:
    options: "="
    filterText: "="
    searchAttribute: "="
    searchAttribute2: "="
  controller: ($scope, $element, $attrs, $location) ->

    $scope.getDataForCol = (row, key, filterName) ->
      colData = row
      keys = key.split '.'
      for key in keys
        colData = colData[key]

      if filterName
        colData = $filter(filterName) colData

      colData

    $scope.linkTo = (data) ->
      id = data.id
      types = Object.keys data

      switch types[2]
        when 'pac' then types[2] = 'pacs'
        when 'elected_official' then types[2] = 'elected-official'
        when 'party' then types[2] = 'parties'

      $location.path "#{types[2]}/#{id}"
