'use strict'
angular.module('bwi-web-client')
  .controller 'ElectedOfficialCtrl', ($scope, Settings, $http, $state, $stateParams, bwiConfig, Pac, Auth) ->
    # if urlService.id
    #   API_URL = "#{bwiConfig.API_URL}/elected_officials/#{urlService.id}"

    $scope.years = [ '2013', '2014' ]

    $http.get("#{bwiConfig.API_URL}/classifications?only_industries")
    .then (response) ->
      $scope.industries = response.data.classifications

    $scope.selectedStartYear = ''
    $scope.selectedEndYear = ''
    $scope.textFilters =
      pac: ''

    $scope.setStartYear = ($item, $model) ->
      $scope.selectedStartYear = $item

    $scope.setEndYear = ($item, $model) ->
      $scope.selectedEndYear = $item

    $http.get "#{bwiConfig.API_URL}/elected_officials/#{$stateParams.id}"
      .then (response) ->
        $scope.data = response.data.elected_official
        $scope.elected_official = true

    $scope.loadPac = ->
      Pac.get
        id: $stateParams.id
        startYear: $scope.selectedStartYear
        endYear: $scope.selectedEndYear
      .then (response) ->

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Pacs (Cumulative)'

        $scope.individualOptions =
          data: response.individual
          title: 'Pacs (Individual)'

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
      when "elected-official.party" then $scope.loadParty()
      when "elected-official.individual" then $scope.loadInd()
