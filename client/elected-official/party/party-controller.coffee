'use strict'

angular.module('bwi-web-client')
  .controller 'PartyCtrl', ($scope, Party, $stateParams, usSpinnerService) ->
    usSpinnerService.spin 'spinner-1'

    $scope.loadParty = ->
      Party.get
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->

        usSpinnerService.stop 'spinner-1'
        
        columnConfig = [
          {
            title: 'Party Name'
            key: 'party.name'
          }
          {
            title: 'Industry'
            key: 'party.industry'
          }
          {
            title: 'Sector'
            key: 'party.sector'
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
          columns: columnConfig

        $scope.individualOptions =
          data: response.individual
          title: 'Parties (Individual)'
          columns: columnConfig

    $scope.loadParty()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadParty()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadParty()
