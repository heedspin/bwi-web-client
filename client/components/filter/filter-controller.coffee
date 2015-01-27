'use strict'

angular.module('bwi-web-client')
  .controller 'FilterCtrl', ($scope, Settings) ->
    $scope.title = 'Senator Bob Rucho (Rep)'
    position = 'democrat'

    if position == 'democrat'
      $scope.position = 'democrat'
    else if position == 'neutral'
      $scope.position = 'neutral'

    $scope.electedOfficial = true

    $scope.years = [
      {
        start: 2010
        end: 2014
      }
      {
        start: 2010
        end: 2014
      }
      {
        start: 2010
        end: 2014
      }
      {
        start: 2010
        end: 2014
      }
      {
        start: 2010
        end: 2014
      }
      {
        start: 2010
        end: 2014
      }
    ]
