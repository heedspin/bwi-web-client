'use strict'

angular.module('bwi-web-client')
  .controller 'ElectedOfficialCtrl', ($scope, $filter, Settings, $http, ngTableParams) ->
    API_BASE_URL = 'http://preprod.bellwetherinsights.com/api/v1/elected_officials/1'
    $scope.tableTitle = 'Pacs (Cumulative)'

    $http.get(API_BASE_URL)
      .then (response) ->
        elected_official = response.data.elected_official
        $scope.elected_official = elected_official

    $scope.loadPac = ->
      $http.get(API_BASE_URL + '/receipts_from_pacs')
        .then (response) ->
          data = response.data.receipts_from_pacs

          $scope.$watch "filter.$", ->
            $scope.tableParams.reload()
            $scope.tableParams.page 1

          $scope.tableParams = new ngTableParams(
            count: data.length
            sorting:
              name: "asc"
          ,
            counts: []
            getData: ($defer, params) ->
              filteredData = $filter("filter")(data, $scope.filter)
              orderedData = (if params.sorting() then $filter("orderBy")(filteredData, params.orderBy()) else filteredData)
              $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())

            $scope: $scope
          )
