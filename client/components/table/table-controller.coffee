'use strict'

angular.module('bwi-web-client')
  .controller 'TableCtrl', ($scope, $filter, ngTableParams, Settings) ->
    $scope.tableTitle = 'Pacs (Cumulative)'

    data = [
      {
        name: "Piedmont Natural Gas"
        industry: "Energy & Natural Resources"
        sector: "Oil & Gas"
        amount: "500.00"
      }
      {
        name: "State Farm Insurance"
        industry: "Finance, Insurance & Real Estate"
        sector: "Insurance"
        amount: "500.00"
      }
      {
        name: "Charlotte Eye Ear Nose & Throat Association"
        industry: "Health"
        sector: "Health Professionals"
        amount: "500.00"
      }
      {
        name: "Manufactured & Modular Homebuilders"
        industry: "Constitution"
        sector: "Home Builders"
        amount: "500.00"
      }
      {
        name: "Paul Stam for NC House"
        industry: "Lawyers & Lobbyist"
        sector: "Lawyers/Law Firm"
        amount: "500.00"
      }
    ]

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
