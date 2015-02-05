'use strict'

angular.module('bwi-web-client')
  .controller 'PacCtrl', ($scope, Pac, $stateParams, usSpinnerService, $state) ->
    type =  $state.current.name.split '.'

    $scope.loadPac = ->
      Pac.get
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->

        cumulativeColumnConfig = [
          {
            title: 'Pac Name'
            key: 'pac.name'
          }
          {
            title: 'Industry'
            key: 'pac.industry'
          }
          {
            title: 'Sector'
            key: 'pac.sector'
          }
          {
            title: 'Amount'
            key: 'amount'
            filter: 'currency'
          }
        ]

        individualColumnConfig = [
          {
            title: 'Pac Name'
            key: 'pac.name'
          }
          {
            title: 'Industry'
            key: 'pac.industry'
          }
          {
            title: 'Sector'
            key: 'pac.sector'
          }
          {
            title: 'Date'
            key: 'date'
            filter: 'date'
          }
          {
            title: 'Amount'
            key: 'amount'
            filter: 'currency'
          }
        ]

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Pacs (Cumulative)'
          columns: cumulativeColumnConfig
          filteredResults: []

        $scope.individualOptions =
          data: response.individual
          title: 'Pacs (Individual)'
          columns: individualColumnConfig
          filteredResults: []

    $scope.loadPac()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadPac()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadPac()

    $scope.$watchCollection 'individualOptions.filteredResults', (newData, oldData) ->
      $scope.graphData = newData

    $scope.clear = ->
      $scope.industry.selected = ''
