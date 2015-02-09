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
      if $select.search
        $http.get "#{API_URL}/entities",
          params:
            term: $select.search
        .then (response) ->
          $scope.results = response.data

          if response.data.length < 1
            $scope.error = 'No Results'
            $('.select .selectize-input').removeClass 'open'
            $('.select').addClass "active"
          else
            $scope.error = ''
            $('.select .selectize-input').addClass 'open'
            $('.select').addClass "active"

    $scope.navigate = (item) ->
      switch item.type
        when 'elected_official'
          $state.go 'elected-official.pac', { id: item.id }
        when 'party'
          $state.go 'parties.expenditures', { id: item.id }
        when 'pac'
          $state.go 'pacs.expenditures', { id: item.id }
