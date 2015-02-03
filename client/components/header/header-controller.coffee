'use strict'

angular.module('bwi-web-client')
  .controller 'HeaderCtrl', ($scope, Settings, $http, $state, urlService, bwiConfig) ->
    API_URL = bwiConfig.API_URL
    $scope.disabled = undefined
    $scope.searchEnabled = undefined
    $scope.searchRes = []

    $scope.searchMedia = ($select) ->
      return $http.get("#{API_URL}/entities",
        params:
          term: $select.search
      ).then (response) ->
        $scope.SearchRes = response.data

    $scope.navigate = (item) ->
      switch item.type
        when 'elected_official'
          $state.go 'elected-official.pac', { id: item.id }
        when 'party'
          # TODO: implement $stateParams
          $state.go 'party'
        when 'pac'
          # TODO: implement $stateParams
          $state.go 'pac'
