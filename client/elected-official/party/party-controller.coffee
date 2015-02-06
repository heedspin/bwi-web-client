'use strict'

angular.module('bwi-web-client')
  .controller 'PartyCtrl', ($scope, Party, $stateParams, $state) ->
    type =  $state.current.name.split '.'
    $scope.loadParty = ->
      Party.get
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
              'pac.name',
              '$scope.filterText'
            ]
          }
        ]

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Parties (Cumulative)'
          columns: cumulativeColumnConfig
          filters: filters

        $scope.individualOptions =
          data: response.individual
          title: 'Parties (Individual)'
          columns: individualColumnConfig
          filters: filters

    $scope.loadParty()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadParty()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadParty()
