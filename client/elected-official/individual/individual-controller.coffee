'use strict'

angular.module('bwi-web-client')
  .controller 'IndividualCtrl', ($scope, Settings, Individual, $stateParams, $state) ->
    type =  $state.current.name.split '.'

    $scope.loadIndividual = ->
      Individual.get
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->

        cumulativeColumnConfig = [
          {
            title: 'Donor Name'
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
            title: 'Amount'
            key: 'amount'
            filter: 'currency'
          }
        ]

        individualColumnConfig = [
          {
            title: 'Donor Name'
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

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Individual (Cumulative)'
          columns: cumulativeColumnConfig

        $scope.individualOptions =
          data: response.individual
          title: 'Individual (Individual)'
          columns: individualColumnConfig

    $scope.loadIndividual()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadIndividual()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadIndividual()
