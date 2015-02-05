'use strict'

angular.module('bwi-web-client')
  .controller 'OrganizationCtrl', ($scope, Settings, $stateParams, $http, $state, bwiConfig) ->
    organizationType = $state.current.name.substring(0, $state.current.name.indexOf('.'))
    BASE_URL = "#{bwiConfig.API_URL}/#{organizationType}/#{$stateParams.id}"

    $scope.yearFilters =
      startYear: '2014'
      endYear: '2014'

    $scope.textFilters =
      text: ''

    $http.get(BASE_URL).then (response) ->
      data = response.data
      if data.pac
        $scope.pac = true
      else
        $scope.party = true

      $scope.data = data.pac || data.party
