'use strict'

angular.module('bwi-web-client')
  .controller 'PartyCtrl', ($scope, Party, $stateParams, $state) ->
    type =  $state.current.name.split '.'

    $scope.loadParty = ->
      $scope.showSpinner = true

      Party.get
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->
        $scope.showSpinner = false

        cumulativeColumnConfig = [
          {
            title: 'Party Name'
            key: 'party.name'
          }
          {
            title: 'Affiliation'
            key: 'party.affiliation'
          }
          {
            title: 'City'
            key: 'party.city'
          }
          {
            title: 'Amount'
            key: 'amount'
            filter: 'currency'
          }
        ]

        individualColumnConfig = [
          {
            title: 'Party Name'
            key: 'party.name'
          }
          {
            title: 'Affiliation'
            key: 'party.affiliation'
          }
          {
            title: 'City'
            key: 'party.city'
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
              'party.name',
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

    $scope.$watch 'yearFilters', $scope.loadParty, true
