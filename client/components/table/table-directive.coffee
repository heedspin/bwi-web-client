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
      values = []
      keys = Object.keys data

      types = [
        {
          name: 'pac'
          value: 'pacs'
        }
        {
          name: 'elected_official'
          value: 'elected-official'
        }
        {
          name: 'party'
          value: 'parties'
        }
      ]

      for i in keys
        values.push
          name: i

      for i in values
        result = _.findWhere types, {name: i.name}

        if result
           id = data["#{result.name}"].id
           $location.path "#{result.value}/#{id}"
