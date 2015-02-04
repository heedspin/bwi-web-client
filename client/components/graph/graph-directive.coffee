'use strict'

angular.module('bwi-web-client')
.directive 'bwiGraph', ->
  templateUrl: 'components/graph/graph.html'
  restrict: 'E'
  scope:
    graphData: '='
  controller: ($scope, $element, $attrs) ->
    $scope.$watch 'graphData', ->
      $scope.groupedData = []

      if $scope.graphData and $scope.graphData.length
        for row in $scope.graphData
          result = _.where $scope.groupedData, { industry: row.pac.industry }

          if result.length == 1
            result[0].amount += row.amount
          else
            $scope.groupedData.push
              industry: row.pac.industry
              amount: row.amount

      totalAmount = 0
      _.each $scope.groupedData, (groupedItem) ->
        totalAmount += groupedItem.amount

      $scope.totalAmount = totalAmount

    $scope.getBarWidth = (row) ->
      barGraphStyle =
        'width': 100 * (row.amount / $scope.totalAmount) + '%'
