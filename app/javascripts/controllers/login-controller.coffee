'use strict'

angular.module('bwi-web-client')
  .controller 'LoginCtrl', ($scope, Settings, $http, bwiConfig, $cookieStore, $cookies, $state, $analytics, $location) ->
    $scope.user = {}

    $scope.login = ->
      $analytics.eventTrack 'Click',
        category: 'Button'
        label: "Login #{$location.path()}"

      user =
        email: $scope.user.email
        password: $scope.user.password

      $http.post("#{bwiConfig.API_URL}/bwi_auth_sessions",
        {email: user.email, password: user.password}
      )
      .success (data) ->
        $http.defaults.headers.common['X-BWI-AUTH-TOKEN'] = data.bwi_auth_token
        $cookieStore.put 'X-BWI-AUTH-TOKEN', data.bwi_auth_token
        $state.go "search"
      .error (data) ->
        $scope.showError = true
