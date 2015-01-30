'use strict'

angular.module('bwi-web-client')
  .controller 'ElectedOfficialCtrl', ($scope, Settings, $http, $state, urlService, bwiConfig, Auth) ->
    if urlService.id
      API_URL = "#{bwiConfig.API_URL}/#{urlService.type}/#{urlService.id}"
    else
      $state.go "search"

    $scope.years = [ '2013', '2014' ]
    $scope.industries = [
      ""
      "Agribuisiness"
      "Communications/Electronics"
      "Construction"
      "Energy & Natural Resources"
      "Finance, Insurance & Real Estate"
      "Health"
      "Ideological/Single-Issue"
      "Labor"
      "Lawyers & Lobbyist"
      "Misc Business"
      "Other"
      "PAC"
      "Transportation"
    ]

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
      $scope.tableTitle = 'Pacs (Cumulative)'

      $http.get("#{API_URL}/receipts_from_pacs")
        .then (response) ->
          data = response.data.receipts_from_pacs
          $scope.tableData = data

    $scope.loadParty = ->
      $scope.tableTitle = 'Party'

      $http.get("#{API_URL}/receipts_from_parties")
        .then (response) ->
          data = response.data.receipts_from_parties
          $scope.tableData = data
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
