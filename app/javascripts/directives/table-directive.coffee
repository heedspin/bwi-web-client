'use strict'

angular.module('bwi-web-client')
.directive 'bwiTable', ($filter) ->
  templateUrl: 'directives/table.html'
  restrict: 'E'
  scope:
    options: "="
    filterText: "="
    onExport: "&"
  controller: ($scope, $element, $attrs, $location, $analytics, $state, User) ->
    unless $attrs.onExport
      $scope.onExport = undefined

    User.current().then (user) ->
      $scope.exportDisabled = user.isLiteServiceLevel()

    $scope.getDataForCol = (row, key, filterName) ->
      colData = row
      keys = key.split '.'
      for key in keys
        colData = colData[key]

      if filterName
        colData = $filter(filterName) colData

      colData

    $scope.getFilteredData = ->
      $scope.options.filteredResults = $scope.options.data

      for filter in $scope.options.filters
        filterArgs = [$scope.options.filteredResults]

        for arg in filter.args
          if arg.indexOf('$scope') > -1
            # Strip out '$scope' from the string, and grab the
            # scope property to pass in as an argument to $filter
            value = $scope

            for key in arg.split('.')[1..]
              if value and typeof value[key] isnt 'undefined'
                value = value[key]
              else
                value = ''

            filterArgs.push value
          else
            filterArgs.push arg

        $scope.options.filteredResults = $filter(filter.name).apply @, filterArgs

      $scope.options.filteredResults

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
          return $state.href(result.value, { id: id })

    timer = undefined
    $scope.analytics = ->
      title = @.options.title
      clearTimeout timer

      timer = setTimeout((->
        $analytics.eventTrack 'Search',
          category: title
          label: "#{$scope.filterText} #{$location.path()}"
      ), 1000)
