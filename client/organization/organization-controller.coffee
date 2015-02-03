'use strict'

angular.module('bwi-web-client')
  .controller 'OrganizationCtrl', ($scope, Settings, $stateParams, $http, $state, bwiConfig) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"
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
      console.log 'TODO'

    $scope.loadExp = ->
      $scope.tableTitle = 'Cumulative Campaign Contributions'
      $http.get("#{BASE_URL}/expenditures")
        .then (response) ->
          data = response.data.expenditures
          $scope.tableData = data
          $scope.parties = data
          console.log data
