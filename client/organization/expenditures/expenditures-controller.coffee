'use strict'

angular.module('bwi-web-client')
  .controller 'ExpendituresCtrl', ($scope, $http, bwiConfig, $state, $stateParams, Expenditures, usSpinnerService) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"

    type =  $state.current.name.split '.'



    $scope.parties = [
      {
        name: 'Republican'
        image: 'Republican-small'
        chambers: []
        amount: 0
        isDisabled: false
      }
      {
        name: 'Democratic'
        image: 'Democratic-small'
        chambers: []
        amount: 0
        isDisabled: false
      }
      {
        name: 'Non-partisan'
        image: 'Non-partisan-small'
        chambers: []
        amount: 0
        isDisabled: false
      }
      {
        name: 'Libertarian'
        image: 'Libertarian-small'
        chambers: []
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
      Expenditures.get
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->
        
        debugger
        cumulativeColumnConfig = [
          {
            title: 'Name'
            key: 'elected_official.name'
          }
          {
            title: 'Affiliation'
            key: 'elected_official.affiliation'
          }
          {
            title: 'Chamber'
            key: 'elected_official.office_chamber'
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
            key: 'elected_official.name'
          }
          {
            title: 'Affiliation'
            key: 'elected_official.affiliation'
          }
          {
            title: 'Chamber'
            key: 'elected_official.office_chamber'
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
          title: 'Cumulative Campaign Contributions'
          columns: cumulativeColumnConfig

        $scope.individualOptions =
          data: response.individual
          title: 'Campaign Contributions'
          columns: individualColumnConfig

        for i in response.individual

          party = _.where $scope.parties, { name: i.elected_official.affiliation }
          chamber = _.where $scope.chambers, { name: i.elected_official.office_chamber }

          if party.length is 1
            party[0].amount += i.amount

          if chamber.length is 1
            chamber[0].amount += i.amount

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

    $scope.clearParty = ->
      $scope.party.selected = ''

      for i in $scope.parties
        i.isDisabled = false

    $scope.clearChamber = ->
      $scope.chamber.selected = ''

      for i in $scope.chambers
        i.isDisabled = false
