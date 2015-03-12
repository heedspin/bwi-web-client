'use strict'

angular.module('bwi-web-client')
  .controller 'IndividualCtrl', ($scope, Settings, Individual, $stateParams, $state) ->
    type =  $state.current.name.split '.'

    $scope.loadIndividual = ->
      $scope.showSpinner = true

      Individual.get
        type: type
        id: $stateParams.id
        yearFilters: $scope.yearFilters
      .then (response) ->
        $scope.showSpinner = false

        cumulativeColumnConfig = [
          {
            title: 'Name'
            key: 'donor.name'
          }
          {
            title: 'Employer'
            key: 'donor.employer'
          }
          {
            title: 'Profession'
            key: 'donor.profession'
          }
          {
            title: 'Total'
            key: 'amount'
            filter: 'currency'
          }
        ]

        individualColumnConfig = [
          {
            title: 'Name'
            key: 'donor.name'
          }
          {
            title: 'Employer'
            key: 'donor.employer'
          }
          {
            title: 'Profession'
            key: 'donor.profession'
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
              'donor.name',
              '$scope.filterText'
            ]
          }
        ]

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Cumulative'
          columns: cumulativeColumnConfig
          filters: filters

        $scope.individualOptions =
          data: response.individual
          title: 'Individual'
          columns: individualColumnConfig
          filters: filters

    $scope.$watch 'yearFilters', $scope.loadIndividual, true

    $scope.exportToExcel = ->
      Individual.exportToExcel
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
