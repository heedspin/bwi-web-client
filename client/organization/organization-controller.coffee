'use strict'

angular.module('bwi-web-client')
  .controller 'OrganizationCtrl', ($scope, Settings, $stateParams, $http, $state, urlService, bwiConfig) ->
    republican = []
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
      $scope.tableTitle = 'Contributions By Party'

      $http.get("#{API_URL}/expenditures")
        .then (response) ->
          data = response.data.expenditures
          $scope.tableData = data

          republican = _.groupBy data, 'affiliation'
          console.log republican

