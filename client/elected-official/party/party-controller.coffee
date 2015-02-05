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

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Parties (Cumulative)'
          columns: cumulativeColumnConfig

        $scope.individualOptions =
          data: response.individual
          title: 'Parties (Individual)'
          columns: individualColumnConfig

    $scope.loadParty()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadParty()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadParty()
