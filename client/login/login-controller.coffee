'use strict'

angular.module('bwi-web-client')
  .controller 'LoginCtrl', ($scope, Settings, $http, bwiConfig, $cookieStore, $cookies) ->
    user = []

    $scope.login = ->
      user =
        email: $scope.user.email
        password: $scope.user.password

      $http.post("#{bwiConfig.API_URL}/bwi_auth_sessions",
        {email: user.email, password: user.password}
      )
      .then (response) ->
        $cookieStore.put 'BWI_AUTH_TOKEN', response.data.BWI_AUTH_TOKEN
