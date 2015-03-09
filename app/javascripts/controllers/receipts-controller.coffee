'use strict'

angular.module('bwi-web-client')
  .controller 'ReceiptsCtrl', ($scope, Settings, bwiConfig, $state, $stateParams, $http, Receipt) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"
    type =  $state.current.name.split '.'

    $scope.loadReceipts = ->
      $scope.showSpinner = true

      Receipt.get
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
          title: 'Cumulative Receipts'
          columns: cumulativeColumnConfig
          filters: filters

        $scope.individualOptions =
          data: response.individual
          title: 'Individual Receipts'
          columns: individualColumnConfig
          filters: filters

    $scope.$watch 'yearFilters', $scope.loadReceipts, true

    $scope.exportToExcel = ->
      Receipt.exportToExcel
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
