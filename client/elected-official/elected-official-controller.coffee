'use strict'
angular.module('bwi-web-client')
  .controller 'ElectedOfficialCtrl', ($scope, Settings, $http, $state, $stateParams, bwiConfig, Auth) ->

    $http.get("#{bwiConfig.API_URL}/classifications?only_industries")
    .then (response) ->
      $scope.industries = [""].concat response.data.classifications

    $scope.yearFilters =
      startYear: '2014'
      endYear: '2014'

    $scope.textFilters =
      text: ''

    $http.get "#{bwiConfig.API_URL}/elected_officials/#{$stateParams.id}"
      .then (response) ->
        $scope.data = response.data.elected_official
        $scope.elected_official = true


    $scope.loadInd = ->
      $http.get("#{API_URL}/receipts_from_individuals")
        .then (response) ->
          data = response.data.receipts_from_individuals
          $scope.tableData = data
