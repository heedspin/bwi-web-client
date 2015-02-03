'use strict'
angular.module('bwi-web-client')
  .controller 'ElectedOfficialCtrl', ($scope, Settings, $http, $state, $stateParams, bwiConfig, Pac, Auth) ->
    $http.get("#{bwiConfig.API_URL}/classifications?only_industries")
    .then (response) ->
      $scope.industries = response.data.classifications

    $scope.yearFilters =
      startYear: '2014'
      endYear: '2014'

    $scope.textFilters =
      pac: ''

    $http.get "#{bwiConfig.API_URL}/elected_officials/#{$stateParams.id}"
      .then (response) ->
        $scope.data = response.data.elected_official
        $scope.elected_official = true

    $scope.$watch 'yearFilters.startYear', (val) ->
      $scope.loadPac()

    $scope.$watch 'yearFilters.endYear', (val) ->
      $scope.loadPac()

    $scope.loadPac = ->
      Pac.get
        id: $stateParams.id
        startYear: $scope.yearFilters.startYear
        endYear: $scope.yearFilters.endYear
      .then (response) ->

        columnConfig = [
          {
            title: 'Pac Name'
            key: 'pac.name'
          }
          {
            title: 'Industry'
            key: 'pac.industry'
          }
          {
            title: 'Sector'
            key: 'pac.sector'
          }
          {
            title: 'Amount'
            key: 'amount'
            filter: 'currency'
          }
        ]

        $scope.cumulativeOptions =
          data: response.cumulative
          title: 'Pacs (Cumulative)'
          columns: columnConfig

        $scope.individualOptions =
          data: response.individual
          title: 'Pacs (Individual)'
          columns: columnConfig

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
