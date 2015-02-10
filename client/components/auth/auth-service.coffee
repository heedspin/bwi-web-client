'user strict'

angular.module('bwi-web-client')
  .factory "Auth", ($cookieStore, $state) ->
    signOut: ->
      $cookieStore.remove 'X-BWI-AUTH-TOKEN'
      $state.go $state.$current, null,
        reload: true

    isLoggedIn: ->
      typeof($cookieStore.get("X-BWI-AUTH-TOKEN")) != 'undefined'
