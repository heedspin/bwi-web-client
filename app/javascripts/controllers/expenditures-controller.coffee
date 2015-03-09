'use strict'

angular.module('bwi-web-client')
  .controller 'ExpendituresCtrl', ($scope, $http, bwiConfig, $state, $stateParams, Expenditures, $analytics, $location) ->
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
      $scope.showSpinner = true

      Expenditures.get
        type: type
        id: $stateParams.id
        yearFilters: $scope.yearFilters
      .then (response) ->
        $scope.showSpinner = false

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
              'elected_official.office_chamber',
              '$scope.$parent.chamber.selected.name'
            ]
          }
          {
            name: 'keyFilter'
            args: [
              'elected_official.affiliation',
              '$scope.$parent.party.selected.name'
            ]
          }
          {
            name: 'keyFilter'
            args: [
              'elected_official.name',
              '$scope.filterText'
            ]
          }
        ]

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Cumulative Campaign Contributions'
          columns: cumulativeColumnConfig
          filteredResults: []
          filters: filters

        $scope.individualOptions =
          data: response.individual
          title: 'Campaign Contributions'
          columns: individualColumnConfig
          filteredResults: []
          filters: filters

    $scope.$watch 'yearFilters', $scope.loadExp, true

    $scope.$watchCollection 'cumulativeOptions.filteredResults', (newVal, oldVal) ->
      if newVal
        clearPartyAmounts()
        clearChamberAmounts()
        setPartyAmounts newVal
        setChamberAmounts newVal

    clearPartyAmounts = ->
      for party in $scope.parties
        party.amount = 0

    setPartyAmounts = (results) ->
      for result in results
        party = _.where $scope.parties, { name: result.elected_official.affiliation }
        if party.length is 1 then party[0].amount += result.amount

    clearChamberAmounts = ->
      for chamber in $scope.chambers
        chamber.amount = 0

    setChamberAmounts = (results) ->
      for result in results
        chamber = _.where $scope.chambers, { name: result.elected_official.office_chamber }
        if chamber.length is 1 then chamber[0].amount += result.amount

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

    $scope.party = ->
      $analytics.eventTrack 'Select',
        category: 'Party Dropdown'
        label: "#{$scope.party.selected.name} #{$location.path()}"

    $scope.chamber = ->
      $analytics.eventTrack 'Select',
        category: 'Chamber Dropdown'
        label: "#{$scope.chamber.selected.name} #{$location.path()}"

    $scope.exportToExcel = ->
      Expenditures.exportToExcel
        type: type
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
