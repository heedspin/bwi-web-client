'use strict'

angular.module('bwi-web-client')
  .controller 'SearchCtrl', ($scope, Settings, $http, $state, urlService, bwiConfig, $cookieStore) ->
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

    $scope.test = (item) ->
      switch item.type
        when 'elected_official' then item.type = 'elected_officials'
        when 'party' then item.type = 'parties'
        when 'pac' then item.type = 'pacs'

      urlService.id = item.id
      urlService.type = item.type

      switch urlService.type
        when 'pacs' then $state.go 'pac'
        when 'elected_officials' then $state.go 'elected-official'
        when 'parties' then $state.go 'party'

    $scope.clearLogin = ->
      $state.go $state.current, {},
        reload: true
      $cookieStore.remove 'X-BWI-AUTH-TOKEN'
      console.log 'removed'

