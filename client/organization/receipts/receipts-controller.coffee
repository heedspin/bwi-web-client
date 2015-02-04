'use strict'

angular.module('bwi-web-client')
  .controller 'ReceiptsCtrl', ($scope, Settings, bwiConfig, $state, $stateParams, $http) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"

    $scope.chambers = [
      {
        name: 'Council of State'
        image: 'Council-of-State'
        amount: 0
        isDisabled: false

      }
      {
        name: 'House'
        image: 'House'
        amount: 0
        isDisabled: false

      }
      {
        name: 'Senate'
        image: 'Senate'
        amount: 0
        isDisabled: false

      }
    ]

    $scope.loadReceipts = ->
      $http.get("#{BASE_URL}/receipts_from_individuals")
      .then (response) ->
        data = response.data.receipts_from_individuals

        $scope.cumulativeOptions =
          data: data
          title: 'Cumulative Receipts'

        $scope.individualOptions =
          data: data
          title: 'Individual Receipts'

    $scope.loadReceipts()

    $scope.$watch "chamber.selected", (val) ->
      if val
        for chamber in $scope.chambers
          chamber.isDisabled = true

        val.isDisabled = false
