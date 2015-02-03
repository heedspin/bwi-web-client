angular.module('bwi-web-client')
.directive 'bwiSearch', (bwiConfig, $state, $http) ->
  templateUrl: 'components/search/search.html'
  replace: true
  restrict: 'E'
  scope: {}
  controller: ($scope, $element, $attrs) ->
    $scope.disabled = undefined
    $scope.enabled = undefined
    $scope.results = []
    API_URL = bwiConfig.API_URL

    $scope.searchMedia = ($select) ->
      $http.get "#{API_URL}/entities",
        params:
          term: $select.search
      .then (response) ->
        $scope.results = response.data

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
