'use strict'

angular.module('bwi-web-client')
  .controller 'ReceiptsCtrl', ($scope, Settings, bwiConfig, $state, $stateParams, $http, Receipt) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"
    type =  $state.current.name.split '.'

    $scope.loadReceipts = ->
      Receipt.get
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->

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

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Cumulative Receipts'
          columns: cumulativeColumnConfig

        $scope.individualOptions =
          data: response.individual
          title: 'Individual Receipts'
          columns: individualColumnConfig


    $scope.loadReceipts()
