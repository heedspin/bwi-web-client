'use strict'

angular.module('bwi-web-client')
  .controller 'PacCtrl', ($scope, Pac, $stateParams, usSpinnerService) ->
    usSpinnerService.spin 'spinner-1'

    $scope.loadPac = ->
      Pac.get
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->

        usSpinnerService.stop 'spinner-1'

        columnConfig = [
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

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Pacs (Cumulative)'
          columns: columnConfig
          filteredResults: []

        $scope.individualOptions =
          data: response.individual
          title: 'Pacs (Individual)'
          columns: columnConfig
          filteredResults: []

    $scope.loadPac()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadPac()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadPac()

    $scope.$watchCollection 'individualOptions.filteredResults', (newData, oldData) ->
      $scope.graphData = newData
