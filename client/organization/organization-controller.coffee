'use strict'

angular.module('bwi-web-client')
  .controller 'OrganizationCtrl', ($scope, Settings, $stateParams, $http, $state, bwiConfig) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"

    parties = [
      {
        name: 'Republican'
        image: 'Republican-small'
        amount: 0
      }
      {
        name: 'Democratic'
        image: 'Democratic-small'
        amount: 0
      }
      {
        name: 'Non-partisan'
        image: 'Non-partisan-small'
        amount: 0
      }
      {
        name: 'Libertarian'
        image: 'Libertarian-small'
        amount: 0
      }
    ]

    chambers = [
      {
        name: 'Council of State'
        image: 'Council-of-State'
        amount: 0
      }
      {
        name: 'House'
        image: 'House'
        amount: 0
      }
      {
        name: 'Senate'
        image: 'Senate'
        amount: 0
      }
    ]

    $scope.chambers = chambers
    $scope.parties = parties

    $scope.years = [ '2013', '2014' ]
    $scope.selectedStartYear = ''
    $scope.selectedEndYear = ''

    $scope.setStartYear = ($item, $model) ->
      $scope.selectedStartYear = $item

    $scope.setEndYear = ($item, $model) ->
      $scope.selectedEndYear = $item

    $http.get(BASE_URL).then (response) ->
      data = response.data
      if data.pac
        $scope.pac = true
      else
        $scope.party = true

      $scope.data = data.pac || data.party

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

    $scope.loadExp = ->
      $scope.tableTitle = 'Cumulative Campaign Contributions'
      $http.get("#{BASE_URL}/expenditures")
      .then (response) ->
        data = response.data.expenditures
        
        for i in data
          party = _.where $scope.parties, { name: i.elected_official.affiliation }

          if party.length is 1
            party[0].amount += i.amount
