'use strict'
angular.module('bwi-web-client')
  .controller 'ElectedOfficialCtrl', ($scope, Settings, $http, $state, urlService, bwiConfig, Auth) ->
    if urlService.id
      API_URL = "#{bwiConfig.API_URL}/#{urlService.type}/#{urlService.id}"
    else
      $state.go "search"

    $scope.years = [ '2013', '2014' ]

    $http.get("#{bwiConfig.API_URL}/classifications?only_industries")
      .then (response) ->
        $scope.industries = response.data.classifications

    $scope.selectedStartYear = ''
    $scope.selectedEndYear = ''

    $scope.setStartYear = ($item, $model) ->
      $scope.selectedStartYear = $item

    $scope.setEndYear = ($item, $model) ->
      $scope.selectedEndYear = $item

    $http.get(API_URL)
      .then (response) ->
        $scope.data = response.data.elected_official
        $scope.elected_official = true

    $scope.loadPac = ->
      cumulative = []
      individual = []

      $http.get("#{API_URL}/receipts_from_pacs")
        .then (response) ->
          data = response.data.receipts_from_pacs
          cumulative.data = data
          cumulative.title = 'Pacs (Cumulative)'

          # individual.title = 'Pacs (Individual)'
          # individual.data = data

          $scope.cumulative = cumulative
          $scope.individual = individual

    $scope.loadParty = ->
      $scope.tableTitle = 'Party'

      $http.get("#{API_URL}/receipts_from_parties")
        .then (response) ->
          data = response.data.receipts_from_parties
          $scope.items = data
          console.log data

    $scope.loadInd = ->
      $scope.tableTitle = 'Individual'

      $http.get("#{API_URL}/receipts_from_individuals")
        .then (response) ->
          data = response.data.receipts_from_individuals
          $scope.tableData = data

    switch $state.current.name
      when "elected-official.pac" then $scope.loadPac()
      when "elected-official.party" then $scope.loadParty()
      when "elected-official.individual" then $scope.loadInd()
