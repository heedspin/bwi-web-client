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
        console.log response

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

        filters = [
          {
            name: 'startYear'
            args: [ '$scope.selectedStartYear' ]
          }
          {
            name: 'endYear'
            args: [ '$scope.selectedEndYear' ]
          }
          {
            name: 'keyFilter'
            args: [
              'pac.industry',
              '$scope.$parent.industry.selected.name'
            ]
          }
          {
            name: 'keyFilter'
            args: [
              'pac.name',
              '$scope.filterText'
            ]
          }
        ]

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Pacs (Cumulative)'
          columns: cumulativeColumnConfig
          filteredResults: []
          filters: filters

        $scope.individualOptions =
          data: response.individual
          title: 'Pacs (Individual)'
          columns: individualColumnConfig
          filteredResults: []
          filters: filters

    $scope.loadPac()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadPac()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadPac()

    $scope.$watchCollection 'individualOptions.filteredResults', (newData, oldData) ->
      $scope.graphData = newData

    $scope.clear = ->
      $scope.industry.selected = ''
