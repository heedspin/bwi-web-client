'use strict'

angular.module('bwi-web-client')
  .controller 'ExpendituresCtrl', ($scope, $http, bwiConfig, $state, $stateParams) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"

    $scope.parties = [
      {
        name: 'Republican'
        image: 'Republican-small'
        amount: 0
        isDisabled: false
      }
      {
        name: 'Democratic'
        image: 'Democratic-small'
        amount: 0
        isDisabled: false
      }
      {
        name: 'Non-partisan'
        image: 'Non-partisan-small'
        amount: 0
        isDisabled: false
      }
      {
        name: 'Libertarian'
        image: 'Libertarian-small'
        amount: 0
        isDisabled: false
      }
    ]

    $scope.chambers = [
      {
        name: 'Council of State'
        image: 'council'
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

    $scope.loadExp = ->
      $http.get("#{BASE_URL}/expenditures")
      .then (response) ->
        data = response.data.expenditures

        columnConfig = [
          {
            title: 'Campaign'
            key: 'elected_official.office_chamber'
          }
          {
            title: 'Date'
            key: 'date'
          }
          {
            title: 'Total'
            key: 'amount'
            filter: 'currency'

          }

        ]

        $scope.cumulativeOptions =
          data: data
          title: 'Cumulative Campaign Contributions'
          columns: columnConfig

        $scope.individualOptions =
          data: data
          title: 'Campaign Contributions'
          columns: columnConfig

        for i in data
          party = _.where $scope.parties, { name: i.elected_official.affiliation }

          if party.length is 1
            party[0].amount += i.amount

    $scope.loadExp()

    $scope.$watch "party.selected", (val) ->
      if val
        for party in $scope.parties
          party.isDisabled = true

        val.isDisabled = false

    $scope.$watch "chamber.selected", (val) ->
      if val
        for chamber in $scope.chambers
          chamber.isDisabled = true

        val.isDisabled = false
