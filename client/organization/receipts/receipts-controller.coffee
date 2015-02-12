'use strict'

angular.module('bwi-web-client')
  .controller 'ReceiptsCtrl', ($scope, Settings, bwiConfig, $state, $stateParams, $http, Receipt, usSpinnerService) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"
    type =  $state.current.name.split '.'
    usSpinnerService.spin 'spinner-1'


    $scope.loadReceipts = ->
      Receipt.get
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->
        usSpinnerService.stop 'spinner-1'

        cumulativeColumnConfig = [
          {
            title: 'Donor'
            key: 'donor.name'
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
            title: 'Donor'
            key: 'donor.name'
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
            title: 'Total'
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

    $scope.loadReceipts()

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadReceipts()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadReceipts()
