'use strict'

angular.module('bwi-web-client')
  .controller 'OrganizationCtrl', ($scope, Settings, $stateParams, $http, $state, urlService, bwiConfig) ->

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

    if urlService.id
      API_URL = "#{bwiConfig.API_URL}/#{urlService.type}/#{urlService.id}"
    else
      $state.go "search"

    $scope.years = [ '2013', '2014' ]
    $scope.selectedStartYear = ''
    $scope.selectedEndYear = ''

    $scope.setStartYear = ($item, $model) ->
      $scope.selectedStartYear = $item

    $scope.setEndYear = ($item, $model) ->
      $scope.selectedEndYear = $item

    $http.get(API_URL)
      .then (response) ->
        data = response.data
        if data.pac
          $scope.pac = true
        else
          $scope.party = true

        $scope.data = data.pac || data.party

    $scope.loadExp = ->
      $http.get("#{API_URL}/expenditures")
        .then (response) ->
          data = response.data.expenditures

          for i in data
            party = _.where $scope.parties, { name: data.elected_official.affiliation }
            if party.length is 1
              party[0].amount += i.amount

          $scope.parties = parties
